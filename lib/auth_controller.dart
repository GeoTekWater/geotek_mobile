// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_tek/screens/auth/login_page.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/introduction_screen/splaash_screen.dart';

GetStorage getStorage = GetStorage();

const String usersKey = 'GEOTEK_USERS';
const String sessionKey = 'GEOTEK_USER';
const String reportsKey = 'GEOTEK_REPORTS';

class AuuthController extends GetxController {
  static AuuthController authInstance = Get.find();

  late Rx<User?> user;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSign = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var authRequestInProgress = false.obs;
  var isLoggedIn = false.obs;

  @override
  void onReady() {
    super.onReady();

    user = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, initialScreenSetting);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);

    // Restore local-only session if Firebase has no user yet.
    if (auth.currentUser == null) {
      _restoreLocalSession();
    }
  }

  /// Firebase session drives navigation; local GetStorage session is honored
  /// when Firebase user is null (offline / local-only accounts).
  initialScreenSetting(User? firebaseUser) {
    if (firebaseUser != null) {
      isLoggedIn.value = true;
      _syncSessionFromFirebase(firebaseUser);
      Get.offAll(() => const HomeScreen());
      return;
    }

    final session = getStorage.read(sessionKey);
    if (session != null) {
      isLoggedIn.value = true;
      Get.offAll(() => const HomeScreen());
      return;
    }

    isLoggedIn.value = false;
    Get.offAll(() => const SplashScreen());
  }

  void _restoreLocalSession() {
    final session = getStorage.read(sessionKey);
    if (session != null) {
      isLoggedIn.value = true;
      Get.offAll(() => const HomeScreen());
    } else {
      isLoggedIn.value = false;
    }
  }

  void _syncSessionFromFirebase(User firebaseUser, {String? name}) {
    final existing = getStorage.read(sessionKey);
    final existingMap = existing is Map
        ? Map<String, dynamic>.from(existing)
        : <String, dynamic>{};

    getStorage.write(sessionKey, {
      'email': firebaseUser.email ?? existingMap['email'] ?? '',
      'name': name ??
          firebaseUser.displayName ??
          existingMap['name'] ??
          'No name',
      'uid': firebaseUser.uid,
      'latitude': existingMap['latitude'],
      'longitude': existingMap['longitude'],
      'authProvider': 'firebase',
    });
  }

  void _writeLocalSession({
    required String email,
    required String name,
    double? latitude,
    double? longitude,
    String? uid,
    String authProvider = 'local',
  }) {
    getStorage.write(sessionKey, {
      'email': email,
      'name': name,
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
      'authProvider': authProvider,
    });
  }

  List<Map<String, dynamic>> _readUsers() {
    final raw = getStorage.read(usersKey);
    if (raw == null) return [];
    return List<Map<String, dynamic>>.from(
      (raw as List).map((e) => Map<String, dynamic>.from(e as Map)),
    );
  }

  void _writeUsers(List<Map<String, dynamic>> users) {
    getStorage.write(usersKey, users);
  }

  void _upsertLocalUser(Map<String, dynamic> userData) {
    final users = _readUsers();
    final email = (userData['email'] as String?)?.toLowerCase() ?? '';
    final index = users.indexWhere(
      (user) => (user['email'] as String?)?.toLowerCase() == email,
    );

    if (index != -1) {
      users[index] = {
        ...users[index],
        ...userData,
      };
    } else {
      users.add(userData);
    }
    _writeUsers(users);
  }

  Future<Map<String, double?>> _getCurrentCoordinates() async {
    try {
      final location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return {'latitude': null, 'longitude': null};
        }
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
      }
      if (permission != PermissionStatus.granted &&
          permission != PermissionStatus.grantedLimited) {
        return {'latitude': null, 'longitude': null};
      }

      final data = await location.getLocation();
      return {
        'latitude': data.latitude,
        'longitude': data.longitude,
      };
    } catch (e) {
      log('[LOCATION-ERROR] :: $e');
      return {'latitude': null, 'longitude': null};
    }
  }

  /// Registers with Firebase and mirrors the account into GetStorage
  /// (including latitude / longitude).
  void registration(String email, password, name) async {
    try {
      authRequestInProgress.value = true;

      final normalizedEmail = email.trim().toLowerCase();
      final users = _readUsers();

      final alreadyExistsLocally = users.any(
        (user) =>
            (user['email'] as String?)?.toLowerCase() == normalizedEmail,
      );

      if (alreadyExistsLocally) {
        authRequestInProgress.value = false;
        Get.snackbar(
          'Message',
          'An account with this email already exists.',
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Message'),
          messageText: const Text('An account with this email already exists.'),
          backgroundColor: AppStyles.bgBrightRed,
        );
        return;
      }

      final coords = await _getCurrentCoordinates();
      String? firebaseUid;

      try {
        final credential = await auth.createUserWithEmailAndPassword(
          email: normalizedEmail,
          password: password,
        );
        firebaseUid = credential.user?.uid;

        if (credential.user != null) {
          await credential.user!.updateDisplayName(name.trim());
        }
      } on FirebaseAuthException catch (e) {
        // If Firebase fails (e.g. network), still create a local account.
        log('[FIREBASE-REGISTRATION-FALLBACK] :: $e');
      }

      final newUser = {
        'email': normalizedEmail,
        'name': name.trim(),
        'password': password,
        'latitude': coords['latitude'],
        'longitude': coords['longitude'],
        'uid': firebaseUid,
        'authProvider': firebaseUid != null ? 'firebase' : 'local',
      };

      _upsertLocalUser(newUser);

      _writeLocalSession(
        email: normalizedEmail,
        name: name.trim(),
        latitude: coords['latitude'],
        longitude: coords['longitude'],
        uid: firebaseUid,
        authProvider: firebaseUid != null ? 'firebase' : 'local',
      );

      isLoggedIn.value = true;
      authRequestInProgress.value = false;

      log('[REGISTERED-USER] :: $newUser');
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      authRequestInProgress.value = false;
      log('[REGISTRATION-ERROR] :: $e');

      Get.snackbar(
        'about user',
        'message for user',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Message'),
        messageText: const Text('An error occured during signup.'),
        backgroundColor: AppStyles.bgBrightRed,
      );
    }
  }

  /// Tries Firebase login first, then falls back to local GetStorage users.
  void login(String email, password) async {
    log('[LOGIN FUNCTION CALLED]');
    try {
      authRequestInProgress.value = true;

      final normalizedEmail = email.trim().toLowerCase();

      // 1) Firebase
      try {
        final UserCredential credential =
            await auth.signInWithEmailAndPassword(
          email: normalizedEmail,
          password: password,
        );

        log('[USER] :: ${credential.toString()}');

        final localMatch = _findLocalUser(normalizedEmail, password);
        final coordsLat = localMatch?['latitude'];
        final coordsLng = localMatch?['longitude'];
        final displayName = credential.user?.displayName ??
            localMatch?['name'] ??
            'No name';

        _writeLocalSession(
          email: normalizedEmail,
          name: displayName,
          latitude: coordsLat is num ? coordsLat.toDouble() : null,
          longitude: coordsLng is num ? coordsLng.toDouble() : null,
          uid: credential.user?.uid,
          authProvider: 'firebase',
        );

        // Keep local mirror in sync (without overwriting password if present).
        _upsertLocalUser({
          'email': normalizedEmail,
          'name': displayName,
          'password': password,
          'uid': credential.user?.uid,
          'latitude': coordsLat,
          'longitude': coordsLng,
          'authProvider': 'firebase',
        });

        isLoggedIn.value = true;
        authRequestInProgress.value = false;
        log('[DEBUG] Stored user data: ${getStorage.read(sessionKey)}');
        Get.offAll(() => const HomeScreen());
        return;
      } on FirebaseAuthException catch (e) {
        log('[FIREBASE-LOGIN-FALLBACK] :: $e');
      }

      // 2) Local GetStorage fallback
      final matchedUser = _findLocalUser(normalizedEmail, password);
      if (matchedUser == null) {
        authRequestInProgress.value = false;
        Get.snackbar(
          'Login Details',
          'Invalid email or password.',
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Message'),
          messageText: const Text('Invalid email or password.'),
          backgroundColor: AppStyles.bgBrightRed,
        );
        return;
      }

      _writeLocalSession(
        email: matchedUser['email'],
        name: matchedUser['name'] ?? 'No name',
        latitude: matchedUser['latitude'] is num
            ? (matchedUser['latitude'] as num).toDouble()
            : null,
        longitude: matchedUser['longitude'] is num
            ? (matchedUser['longitude'] as num).toDouble()
            : null,
        uid: matchedUser['uid']?.toString(),
        authProvider: 'local',
      );

      isLoggedIn.value = true;
      authRequestInProgress.value = false;
      log('[DEBUG] Local login stored user: ${getStorage.read(sessionKey)}');
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      authRequestInProgress.value = false;
      log('[LOGIN-ERROR] :: $e');
      Get.snackbar(
        'Login Details',
        'An error occured during login.',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Message'),
        messageText: const Text('An error occured during login.'),
        backgroundColor: AppStyles.bgBrightRed,
      );
    }
  }

  Map<String, dynamic>? _findLocalUser(String email, String password) {
    final users = _readUsers();
    for (final user in users) {
      if ((user['email'] as String?)?.toLowerCase() == email &&
          user['password'] == password) {
        return user;
      }
    }
    return null;
  }

  void forgotPassword(String email) async {
    try {
      authRequestInProgress.value = true;

      final normalizedEmail = email.trim().toLowerCase();

      try {
        await auth.sendPasswordResetEmail(email: normalizedEmail);
        authRequestInProgress.value = false;
        Get.to(() => LoginScreen());
        Get.snackbar(
          'Login Details',
          'message for user',
          snackPosition: SnackPosition.BOTTOM,
          titleText: CustomTextWidget(
            text: 'Message',
            color: AppStyles.bgWhite,
          ),
          messageText: CustomTextWidget(
            text: 'Success, please check your email to proceed.',
            color: AppStyles.bgWhite,
          ),
          backgroundColor: Colors.green.shade800.withOpacity(0.8),
        );
        return;
      } on FirebaseAuthException catch (e) {
        log('[FIREBASE-FORGOT-PASSWORD] :: $e');
      }

      // Local-only guidance if Firebase reset is unavailable.
      final users = _readUsers();
      final exists = users.any(
        (user) =>
            (user['email'] as String?)?.toLowerCase() == normalizedEmail,
      );

      authRequestInProgress.value = false;

      if (!exists) {
        Get.snackbar(
          'Login Details',
          'No account found with this email.',
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Message'),
          messageText: const Text('No account found with this email.'),
          backgroundColor: AppStyles.bgBrightRed,
        );
        return;
      }

      Get.to(() => LoginScreen());
      Get.snackbar(
        'Login Details',
        'message for user',
        snackPosition: SnackPosition.BOTTOM,
        titleText: CustomTextWidget(
          text: 'Message',
          color: AppStyles.bgWhite,
        ),
        messageText: CustomTextWidget(
          text:
              'Password reset email could not be sent. For local accounts, sign in with your existing password or create a new account.',
          color: AppStyles.bgWhite,
        ),
        backgroundColor: Colors.green.shade800.withOpacity(0.8),
      );
    } catch (e) {
      authRequestInProgress.value = false;

      Get.snackbar(
        'Login Details',
        'message for user',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Message'),
        messageText: const Text('An error occured during forgot password.'),
        backgroundColor: AppStyles.bgBrightRed,
      );
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log('[FIREBASE-SIGNOUT-ERROR] :: $e');
    }

    try {
      await googleSign.signOut();
    } catch (e) {
      log('[GOOGLE-SIGNOUT-ERROR] :: $e');
    }

    getStorage.remove(sessionKey);
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      final session = getStorage.read(sessionKey);
      if (session == null && auth.currentUser == null) {
        Get.offAll(() => const AuthenticationScreen());
      }
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final userCredential =
            await auth.signInWithCredential(credential);

        final firebaseUser = userCredential.user;
        if (firebaseUser != null) {
          _writeLocalSession(
            email: firebaseUser.email ?? googleSignInAccount.email,
            name: firebaseUser.displayName ??
                googleSignInAccount.displayName ??
                'No name',
            uid: firebaseUser.uid,
            authProvider: 'google',
          );
          isLoggedIn.value = true;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void sendOTPToEmail(String email) async {
    try {
      final String otpCode = OTP.generateTOTPCodeString(
          'YOUR_SECRET_KEY', DateTime.now().millisecondsSinceEpoch);

      await auth.sendPasswordResetEmail(
          email: email,
          actionCodeSettings: ActionCodeSettings(
            url: 'https://www.example.com/reset_password?otp=$otpCode',
            handleCodeInApp: true,
            iOSBundleId: 'com.example.app',
            androidPackageName: 'com.example.app',
            androidInstallApp: true,
            androidMinimumVersion: '16',
            dynamicLinkDomain: 'example.page.link',
          ));

      Get.snackbar(
        'OTP Sent',
        'An OTP has been sent to your email address.',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again later.',
        backgroundColor: Colors.red,
      );
      print(e);
    }
  }

  void updateProfile(String email) async {
    try {
      log('[UPDATE-PROFILE-PROCESSING]');

      final normalizedEmail = email.trim().toLowerCase();
      final session = getStorage.read(sessionKey);
      final currentEmail =
          (session is Map ? session['email'] as String? : null)
                  ?.toLowerCase() ??
              '';

      // Firestore (Firebase)
      final userId = auth.currentUser?.uid;
      if (userId != null) {
        await _firestore.collection('profile').doc(userId).set({
          'name': session is Map ? (session['name'] ?? 'name') : 'name',
          'email': normalizedEmail,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // GetStorage
      if (session != null) {
        final updatedSession = Map<String, dynamic>.from(session as Map);
        updatedSession['email'] = normalizedEmail;
        getStorage.write(sessionKey, updatedSession);

        final users = _readUsers();
        final index = users.indexWhere(
          (user) =>
              (user['email'] as String?)?.toLowerCase() == currentEmail,
        );
        if (index != -1) {
          users[index]['email'] = normalizedEmail;
          _writeUsers(users);
        }
      }

      log('[UPDATE-PROFILE-SUCCESS]');
    } catch (error) {
      log('[UPDATE-PROFILE-FAILED] :: $error');

      Get.snackbar(
        'Error',
        'An error occured while updating profile',
        backgroundColor: Colors.red,
      );
    }
  }

  /// Saves a water-infrastructure report to local storage.
  void saveReport(Map<String, dynamic> report) {
    final raw = getStorage.read(reportsKey);
    final reports = raw == null
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(
            (raw as List).map((e) => Map<String, dynamic>.from(e as Map)),
          );

    reports.add(report);
    getStorage.write(reportsKey, reports);
    log('[REPORT-SAVED] :: $report');
  }

  List<Map<String, dynamic>> getReports() {
    final raw = getStorage.read(reportsKey);
    if (raw == null) return [];
    return List<Map<String, dynamic>>.from(
      (raw as List).map((e) => Map<String, dynamic>.from(e as Map)),
    );
  }
}

// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:get/get.dart';
// import 'package:otp/otp.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:geo_tek/config/app_config.dart';
// FIREBASE (kept for reference / restore later)
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_tek/screens/auth/login_page.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
// import 'package:geo_tek/screens/auth/authentication_screen.dart';
// import 'package:geo_tek/screens/introduction_screen/splaash_screen.dart';

GetStorage getStorage = GetStorage();

const String usersKey = 'GEOTEK_USERS';
const String sessionKey = 'GEOTEK_USER';
const String reportsKey = 'GEOTEK_REPORTS';

class AuuthController extends GetxController {
  static AuuthController authInstance = Get.find();

  // ──────────────────────────────────────────────
  // FIREBASE AUTH (commented out — restore if needed)
  // ──────────────────────────────────────────────
  // late Rx<User?> user;
  // late Rx<GoogleSignInAccount?> googleSignInAccount;
  // FirebaseAuth auth = FirebaseAuth.instance;
  // GoogleSignIn googleSign = GoogleSignIn();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var authRequestInProgress = false.obs;
  var isLoggedIn = false.obs;

  @override
  void onReady() {
    super.onReady();
    _restoreLocalSession();

    // ── FIREBASE session binding (commented out) ──
    // user = Rx<User?>(auth.currentUser);
    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    // user.bindStream(auth.userChanges());
    // ever(user, initialScreenSetting);
    // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    // ever(googleSignInAccount, _setInitialScreenGoogle);
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

  // ── FIREBASE initial screen (commented out) ──
  // initialScreenSetting(User? user) {
  //   if (user == null) {
  //     print('Login');
  //     Get.offAll(() => const SplashScreen());
  //   } else {
  //     Get.offAll(() => const HomeScreen());
  //   }
  // }

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

  void registration(String email, password, name) async {
    try {
      authRequestInProgress.value = true;

      // ── FIREBASE registration (commented out) ──
      // await auth.createUserWithEmailAndPassword(
      //     email: email, password: password);
      // getStorage.write('GEOTEK_USER', {
      //   "email": email,
      //   "name": name,
      // });
      // authRequestInProgress.value = false;

      final normalizedEmail = email.trim().toLowerCase();
      final users = _readUsers();

      final alreadyExists = users.any(
        (user) =>
            (user['email'] as String?)?.toLowerCase() == normalizedEmail,
      );

      if (alreadyExists) {
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

      final newUser = {
        'email': normalizedEmail,
        'name': name.trim(),
        'password': password,
        'latitude': coords['latitude'],
        'longitude': coords['longitude'],
      };

      users.add(newUser);
      _writeUsers(users);

      final sessionUser = {
        'email': normalizedEmail,
        'name': name.trim(),
        'latitude': coords['latitude'],
        'longitude': coords['longitude'],
      };
      getStorage.write(sessionKey, sessionUser);
      isLoggedIn.value = true;
      authRequestInProgress.value = false;

      log('[REGISTERED-USER] :: $sessionUser');
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

  void login(String email, password) async {
    log('[LOGIN FUNCTION CALLED]');
    try {
      authRequestInProgress.value = true;

      // ── FIREBASE login (commented out) ──
      // UserCredential user = await auth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // log('[USER] :: ${user.toString()}');
      // getStorage.write('GEOTEK_USER', {
      //   "email": email,
      //   "name": user.user?.displayName ?? 'No name',
      // });
      // final stored = getStorage.read('GEOTEK_USER');
      // log('✅ [DEBUG] Stored user data: $stored');
      // authRequestInProgress.value = false;

      final normalizedEmail = email.trim().toLowerCase();
      final users = _readUsers();

      Map<String, dynamic>? matchedUser;
      for (final user in users) {
        if ((user['email'] as String?)?.toLowerCase() == normalizedEmail &&
            user['password'] == password) {
          matchedUser = user;
          break;
        }
      }

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

      final sessionUser = {
        'email': matchedUser['email'],
        'name': matchedUser['name'] ?? 'No name',
        'latitude': matchedUser['latitude'],
        'longitude': matchedUser['longitude'],
      };
      getStorage.write(sessionKey, sessionUser);
      isLoggedIn.value = true;
      authRequestInProgress.value = false;

      log('[DEBUG] Stored user data: $sessionUser');
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

  void forgotPassword(String email) async {
    try {
      authRequestInProgress.value = true;

      // ── FIREBASE forgot password (commented out) ──
      // await auth.sendPasswordResetEmail(email: email);
      // authRequestInProgress.value = false;
      // Get.to(() => LoginScreen());
      // Get.snackbar(
      //   'Login Details',
      //   "message for user",
      //   snackPosition: SnackPosition.BOTTOM,
      //   titleText: CustomTextWidget(
      //     text: 'Message',
      //     color: AppStyles.bgWhite,
      //   ),
      //   messageText: CustomTextWidget(
      //     text: "Success, please check your email to proceed.",
      //     color: AppStyles.bgWhite,
      //   ),
      //   backgroundColor: Colors.green.shade800.withOpacity(0.8),
      // );

      final normalizedEmail = email.trim().toLowerCase();
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
              'Password reset via email is unavailable for local accounts. Please sign in with your existing password or create a new account.',
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
    // ── FIREBASE sign out (commented out) ──
    // await auth.signOut();

    getStorage.remove(sessionKey);
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }

  // ── FIREBASE Google Sign-In (commented out) ──
  // _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
  //   print(googleSignInAccount);
  //   if (googleSignInAccount == null) {
  //     Get.offAll(() => const AuthenticationScreen());
  //   } else {
  //     Get.offAll(() => const HomeScreen());
  //   }
  // }

  // void signInWithGoogle() async {
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
  //
  //     if (googleSignInAccount != null) {
  //       GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //
  //       AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //
  //       await auth
  //           .signInWithCredential(credential)
  //           .catchError((onErr) => print(onErr));
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     print(e.toString());
  //   }
  // }

  // ── FIREBASE OTP (commented out) ──
  // void sendOTPToEmail(String email) async {
  //   try {
  //     final String otpCode = OTP.generateTOTPCodeString(
  //         'YOUR_SECRET_KEY', DateTime.now().millisecondsSinceEpoch);
  //
  //     await auth.sendPasswordResetEmail(
  //         email: email,
  //         actionCodeSettings: ActionCodeSettings(
  //           url: 'https://www.example.com/reset_password?otp=$otpCode',
  //           handleCodeInApp: true,
  //           iOSBundleId: 'com.example.app',
  //           androidPackageName: 'com.example.app',
  //           androidInstallApp: true,
  //           androidMinimumVersion: '16',
  //           dynamicLinkDomain: 'example.page.link',
  //         ));
  //
  //     Get.snackbar(
  //       'OTP Sent',
  //       'An OTP has been sent to your email address.',
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to send OTP. Please try again later.',
  //       backgroundColor: Colors.red,
  //     );
  //     print(e);
  //   }
  // }

  void updateProfile(String email) async {
    try {
      log('[UPDATE-PROFILE-PROCESSING]');

      // ── FIREBASE / Firestore profile update (commented out) ──
      // final userId = auth.currentUser?.uid;
      // if (userId == null) {
      //   throw Exception('No authenticated user found');
      // }
      // await _firestore.collection('profile').doc(userId).set({
      //   'name': 'name',
      //   'email': email,
      //   'createdAt': FieldValue.serverTimestamp(),
      // });

      final session = getStorage.read(sessionKey);
      if (session == null) {
        throw Exception('No authenticated user found');
      }

      final normalizedEmail = email.trim().toLowerCase();
      final currentEmail =
          (session['email'] as String?)?.toLowerCase() ?? '';

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

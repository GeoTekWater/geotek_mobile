// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/auth/signUp_screen.dart';
import 'package:geo_tek/screens/introduction_screen/splaash_screen.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp/otp.dart';

class AuuthController extends GetxController {
  static AuuthController authInstance = Get.find();
  late Rx<User?> user;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSign = GoogleSignIn();

  var authRequestInProgress = false.obs;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, initialScreenSetting);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  initialScreenSetting(User? user) {
    if (user == null) {
      print('Login');
      Get.offAll(() => const SplashScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void registration(String email, password, name) async {
    try {
      authRequestInProgress.value = true;

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      authRequestInProgress.value = false;
    } catch (e) {
      authRequestInProgress.value = false;

      Get.snackbar(
        'about user',
        "message for user",
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Message'),
        messageText: Text("An error occured during signup."),
        // messageText: Text(e.toString()),
        backgroundColor: AppStyles.bgBrightRed,
      );
    }
  }

  void login(String email, password) async {
    try {
      authRequestInProgress.value = true;

      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      debugPrint('[USER] :: ${user.toString()}');

      authRequestInProgress.value = false;
    } catch (e) {
      authRequestInProgress.value = false;

      Get.snackbar(
        'Login Details',
        "message for user",
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Message'),
        messageText: Text("An error occured during login."),
        // messageText: Text(e.toString()),
        backgroundColor: AppStyles.bgBrightRed,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const AuthenticationScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
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

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void sendOTPToEmail(String email) async {
    try {
      // Generate the OTP
      final String otpCode = OTP.generateTOTPCodeString(
          'YOUR_SECRET_KEY', DateTime.now().millisecondsSinceEpoch);

      // Send the OTP to the user's email
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

// void sendPasswordResetEmail(String email) async {
//   //FirebaseAuth _auth = FirebaseAuth.instance;

//   try {
//     await auth.sendPasswordResetEmail(email: email);
//     print("Password reset email sent successfully to $email");
//     // You can show a success message to the user or navigate to a success page.
//   } catch (e) {
//     print("Failed to send password reset email: $e");
//     // Handle the error - You can show an error message to the user or log the error.
//   }
//}
}

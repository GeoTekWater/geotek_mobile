// ignore_for_file: prefer_const_constructors
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../config/app_config.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/text/custom_formpassword_field.dart';
import '../../widgets/text/custom_text_widget.dart';
import '../../widgets/text/cutom_formtext_field.dart';
import 'verification_screen.dart';
import 'login_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  RegExp emailPattern = RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}");
  RegExp passwordPattern =
      RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,60}$");
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Map dto = {};

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signupHandler() async {
    if (!fullnameController.text.trim().isNotEmpty ||
        !emailController.text.trim().isNotEmpty ||
        !passwordController.text.trim().isNotEmpty ||
        !confirmPasswordController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR!',
        'Please ensure your fill in all fields in the form as the are required.',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (!emailPattern.hasMatch(emailController.text.trim())) {
      Get.snackbar(
        'ERROR!',
        'Invalid email address',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      Get.snackbar(
        'ERROR!',
        'Passwords do not match',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (!passwordPattern.hasMatch(passwordController.text.trim())) {
      Get.snackbar(
        'ERROR!',
        'Password must include a number, uppercase and lowercase alphabet',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (passwordController.text.trim().length <= 7) {
      Get.snackbar(
        'ERROR!',
        'Password must be at least 8 characters',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else {
      AuuthController.authInstance.registration(emailController.text, passwordController.text, fullnameController.text);

  }
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // SizedBox(height: 6.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      hintText: 'Fullname',
                      controller: fullnameController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: AppStyles.bgBlack,
                      fontSize: constructFontSize(context, 14),
                      textColor: AppStyles.bgBlack,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      hintText: 'Email',
                      controller: emailController,
                      background: Colors.white.withOpacity(0.4),
                      fontSize: constructFontSize(context, 14),
                      hintColor: AppStyles.bgBlack,
                      textColor: AppStyles.bgBlack,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormPasswordField(
                      controller: passwordController,
                      hintText: 'Password',
                      fontColor: AppStyles.bgBlack,
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ),
                      showPassword: showPassword,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormPasswordField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm password',
                      fontColor: AppStyles.bgBlack,
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ),
                      showPassword: showConfirmPassword,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(height: 3.0.hp),
                    // authServices.authRequestStatus.value == 'PENDING'
                    //     ? CircularProgressIndicator()
                    // :
                    CustomButton(
                      text: 'Sign Up',
                      width: double.maxFinite,
                      // width: 25.0.hp,
                      height: 6.0.hp,
                      onTapHandler: () {
                        signupHandler();
                        //Get.to(VerificationScreen());
                      },
                      fontSize: constructFontSize(context, 18),
                      // fontSize: 12.0.sp,
                      borderRadius: 40,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppStyles.bgPrimary,
                    ),
                    SizedBox(height: 3.0.hp),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: AppStyles.bgGray),
                        ),
                        SizedBox(width: 4.0.wp),
                        CustomTextWidget(
                          text: 'Or signup with',
                          // size: 12.0.sp,
                          size: constructFontSize(context, 16),
                          color: AppStyles.bgGray4,
                        ),
                        SizedBox(width: 4.0.wp),
                        Expanded(
                          child: Divider(color: AppStyles.bgGray),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0.hp),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                           AuuthController.authInstance.googleSignInAccount();
                          },
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
                            decoration: BoxDecoration(
                                color: AppStyles.bgWhite.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppStyles.bgBlue, blurRadius: 3)
                                ]),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/icons/icon__google.svg'),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // OAUTH-FACEBOOK: SIGNUP
                            Get.snackbar(
                              'Message',
                              'Coming soon!',
                              colorText: Colors.white,
                              backgroundColor:
                                  AppStyles.bgBlue.withOpacity(0.4),
                            );
                          },
                          //ttyyyyuuutr
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
                            decoration: BoxDecoration(
                                color: AppStyles.bgWhite.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppStyles.bgBlue,
                                    blurRadius: 3,
                                  )
                                ]),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/icons/icon__facebook.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'Already have an account? ',
                      // size: 12.0.sp,
                      size: constructFontSize(context, 16),
                      color: AppStyles.bgGray4,
                    ),
                    GestureDetector(
                      onTap: () {
                        // GO-TO: SIGNUP
                        Get.to(
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 800),
                          () => LoginScreen(),
                        );
                      },
                      child: CustomTextWidget(
                        text: 'Login',
                        size: constructFontSize(context, 16),
                        // size: 12.0.sp,
                        color: AppStyles.bgBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

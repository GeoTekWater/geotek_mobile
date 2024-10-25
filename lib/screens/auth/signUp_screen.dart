// ignore_for_file: prefer_const_constructors
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/text/custom_formpassword_field.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
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
      RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,60}$");
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
      AuuthController.authInstance.registration(emailController.text,
          passwordController.text, fullnameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.to(() => LoginScreen());

        return false;
      },
      child: Obx(
        () => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.3,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppStyles.bgWhite,
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12.0.hp,
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.8.hp),
                    decoration: BoxDecoration(
                      color: AppStyles.bgGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          fontColor: AppStyles.bgGray,
                          text: 'Login',
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 6.0.hp,
                          onTapHandler: () {
                            Get.to(() => LoginScreen());
                          },
                          // fontSize: 12.0.sp,
                          fontSize: constructFontSize(context, 18),
                          borderRadius: 40,
                          // fontColor: AppStyles.bgBlue,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.transparent,
                        ),
                        CustomButton(
                          fontColor: AppStyles.bgWhite,
                          text: 'Signup',
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 6.0.hp,
                          onTapHandler: () {
                            Get.to(() => SignupScreen());
                          },
                          // fontSize: 12.0.sp,
                          fontSize: constructFontSize(context, 18),
                          borderRadius: 40,
                          // fontColor: AppStyles.bgBlue,
                          fontWeight: FontWeight.bold,
                          backgroundColor: AppStyles.bgPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: AppStyles.bgWhite,
                height: screenHeight * 0.70,
                padding: EdgeInsets.symmetric(
                  horizontal: AppLayout.getWidth(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 2.0.hp),
                        CustomFormTextField(
                          maxLines: 1,
                          hintText: 'Fullname',
                          controller: fullnameController,
                          background: Colors.white.withOpacity(0.4),
                          hintColor: AppStyles.bgBlack,
                          fontSize: constructFontSize(context, 14),
                          textColor: AppStyles.bgBlack,
                        ),
                        SizedBox(height: 1.5.hp),
                        CustomFormTextField(
                          maxLines: 1,
                          hintText: 'Email',
                          controller: emailController,
                          background: Colors.white.withOpacity(0.4),
                          fontSize: constructFontSize(context, 14),
                          hintColor: AppStyles.bgBlack,
                          textColor: AppStyles.bgBlack,
                        ),
                        SizedBox(height: 1.5.hp),
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
                        SizedBox(height: 1.5.hp),
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
                        SizedBox(height: 1.5.hp),
                        AuuthController
                                    .authInstance.authRequestInProgress.value ==
                                true
                            ? CircularProgressIndicator()
                            : CustomButton(
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
                                Get.snackbar(
                                  'Message',
                                  'Coming soon!',
                                  colorText: Colors.white,
                                  backgroundColor:
                                      AppStyles.bgBlue.withOpacity(0.4),
                                );
                                // AuuthController.authInstance
                                //     .googleSignInAccount();
                              },
                              child: Container(
                                width: 20.0.wp,
                                height: 6.0.hp,
                                decoration: BoxDecoration(
                                    color: AppStyles.bgWhite.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppStyles.bgBlue,
                                          blurRadius: 3)
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

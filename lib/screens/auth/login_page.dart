// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/screens/auth/signUp_screen.dart';
import 'package:geo_tek/screens/introduction_screen/onboarding_screen.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../auth_controller.dart';
import '../../widgets/text/custom_formpassword_field.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  final authStorage = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Google Signin
  var googleSignin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signinHandler() async {
    //Get.off(() => HomeScreen());
    if (!emailController.text.trim().isNotEmpty ||
        !passwordController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR!',
        'Please ensure your fill in all fields in the form as the are required.',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else {
      AuuthController.authInstance
          .login(emailController.text, passwordController.text);
      // if (authServices.authRequestError.value == 'Incorrect password') {
      //   Get.snackbar(
      //     'ERROR!',
      //     authServices.authRequestError.value,
      //     colorText: Colors.white,
      //     duration: Duration(seconds: 5),
      //     backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      //   );
      // }
      //   if (authServices.authRequestError.value == 'Email is not registered!') {
      //     Get.snackbar(
      //       'ERROR!',
      //       authServices.authRequestError.value,
      //       colorText: Colors.white,
      //       duration: Duration(seconds: 5),
      //       backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      //     );
      //   }

      //   if (authServices.authRequestError.value == 'ACCOUNT UNVERIFIED') {
      //     Get.snackbar(
      //       'ERROR!',
      //       'Please check your mail for an activation token to activate your account.',
      //       colorText: Colors.white,
      //       duration: Duration(seconds: 5),
      //       backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      //     );
      //   }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.to(() => OnBoardingScreen());

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
                          fontColor: AppStyles.bgWhite,
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
                          backgroundColor: AppStyles.bgPrimary,
                        ),
                        CustomButton(
                          fontColor: AppStyles.bgGray,
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
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: AppStyles.bgWhite,
              height: screenHeight * 0.70,
              padding: EdgeInsets.symmetric(
                //vertical: AppLayout.getHeight(20),
                horizontal: AppLayout.getWidth(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: 2.0.hp),
                  CustomFormTextField(
                      hintText: 'Email',
                      maxLines: 1,
                      controller: emailController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: AppStyles.bgBlack,
                      textColor: AppStyles.bgBlack),
                  SizedBox(height: 4.0.hp),
                  CustomFormPasswordField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    fontColor: AppStyles.bgBlack,
                    suffixIcon: ImageIcon(
                      AssetImage('assets/icons/icon__eye.png'),
                    ),
                    showPassword: showPassword,
                    background: Colors.white.withOpacity(0.4),
                  ),
                  SizedBox(height: 1.0.hp),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          transition: Transition.zoom,
                          duration: Duration(milliseconds: 500),
                          () => ForgotPasswordScreen(),
                        );
                      },
                      child: CustomTextWidget(
                        text: 'Forgot Password?',
                        size: constructFontSize(context, 14),
                        // size: 12.0.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            transition: Transition.zoom,
                            duration: Duration(milliseconds: 500),
                            () => print('Remeber me'),
                          );
                        },
                        child: CustomTextWidget(
                          text: 'Remember me',
                          size: constructFontSize(context, 14),
                          // size: 12.0.sp,
                          color: AppStyles.bgBlack,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = !rememberMe;
                          });

                          debugPrint('[REMEMBER ME] :: $rememberMe');
                        },
                        inactiveTrackColor: AppStyles.bgPrimary,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0.hp),
                  AuuthController.authInstance.authRequestInProgress.value ==
                          true
                      ? CircularProgressIndicator()
                      : CustomButton(
                          text: 'Login',
                          width: double.maxFinite,
                          // width: 20.0.hp,
                          height: 6.0.hp,
                          onTapHandler: () {
                            //signinHandler();
                            // AuuthController.authInstance
                            //     .sendOTPToEmail(emailController.text);
                            AuuthController.authInstance.login(
                                emailController.text.trim(),
                                passwordController.text.trim());
                            //sendOTPToEmail(emailController.text);
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
                        text: 'OR',
                        size: 12.0.sp,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // if (kDebugMode) {
                          //   print('click');
                          // }
                          Get.snackbar(
                            'Message',
                            'Coming soon!',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.4),
                          );
                          // // OAUTH-GOOGLE: LOGIN
                          // AuuthController.authInstance.signInWithGoogle();
                        },
                        child: Container(
                          width: 20.0.wp,
                          height: 7.0.hp,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppStyles.bgBlue,
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                )
                              ]),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/icons/icon__google.svg'),
                          ),
                        ),
                      ),
                      //SizedBox(width:5.0.hp),
                      GestureDetector(
                        onTap: () {
                          // OAUTH-FACEBOOK: LOGIN
                          Get.snackbar(
                            'Message',
                            'Coming soon!',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.4),
                          );
                        },
                        child: Container(
                          width: 20.0.wp,
                          height: 7.0.hp,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppStyles.bgBlue,
                                  spreadRadius: 0,
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
            ),
          ),
        ),
      ),
    );
  }
}

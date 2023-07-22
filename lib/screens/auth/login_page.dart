// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  Map dto = {};
  var googleSignin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signinHandler() async {
    Get.off(() => HomeScreen());
    if (!emailController.text.trim().isNotEmpty ||
        !passwordController.text.trim().isNotEmpty) {
      // Get.snackbar(
      //   'ERROR!',
      //   'Please ensure your fill in all fields in the form as the are required.',
      //   colorText: Colors.white,
      //   duration: Duration(seconds: 5),
      //   backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      // );
    } else {
      Map data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };
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
        //await authServices.signoutController();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              //vertical: AppLayout.getHeight(20),
              horizontal: AppLayout.getWidth(40),
            ),
            child: Column(
              children: [
                // SizedBox(height: 6.0.hp),
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
                //authServices.authLoading.value == true
                // ? CircularProgressIndicator()
                // :
                CustomButton(
                  text: 'Login',
                  width: double.maxFinite,
                  // width: 20.0.hp,
                  height: 6.0.hp,
                  onTapHandler: () {
                    signinHandler();
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
                        // OAUTH-GOOGLE: LOGIN
                        debugPrint('[GOOGLE-SIGNIN]');
                        _googleSignIn.signOut();
                        _googleSignIn.signIn().then((value) {
                          String email = value!.email;
                          String fullName = '${value.displayName}';
                          String profilePicture = '${value.photoUrl}';

                          debugPrint('[EMAIL] :: ${email}');
                          debugPrint('[USERNAME] :: ${fullName}');
                          debugPrint('[PROFILE-PICTURE] :: ${profilePicture}');
                          setState(() {
                            dto['email'] = email;
                            dto['password'] = email;
                            dto['fullName'] = fullName;
                          });

                          // authServices.googleSigninController(dto);
                        });
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
                          child:
                              SvgPicture.asset('assets/icons/icon__google.svg'),
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
    );
  }
}

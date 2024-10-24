// ignore_for_file: prefer_const_constructors
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:geo_tek/screens/auth/password_reset_verify_screen.dart';
import 'package:geo_tek/widgets/card/custom_message_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/text/custom_text_widget.dart';
import '../../widgets/text/cutom_formtext_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              vertical: AppLayout.getHeight(10),
              horizontal: AppLayout.getWidth(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
                SizedBox(height: 10.0.hp),
                Center(
                  child: CustomTextWidget(
                    text: 'Password Reset',
                    // size: 25.0.sp,
                    size: constructFontSize(context, 20),
                    color: AppStyles.bgPrimary,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0.hp),
                CustomTextWidget(
                  text: 'Please Enter your Email Address',
                  // size: 12.0.sp,
                  size: constructFontSize(context, 16),
                  alignment: TextAlign.center,
                  color: AppStyles.bgBlack,
                  // weight: FontWeight.bold,
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  hintText: 'Email',
                  maxLines: 1,
                  controller: emailController,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: AppStyles.bgBlack,
                  textColor: AppStyles.bgBlack,
                ),
                SizedBox(height: 2.0.hp),
                Center(
                  child: CustomTextWidget(
                    text:
                        'A password reset code will be send to your email address',
                    // size: 12.0.sp,
                    alignment: TextAlign.center,
                    size: constructFontSize(context, 16),
                  ),
                ),
                SizedBox(height: 18.0.hp),
                AuuthController.authInstance.authRequestInProgress.value == true
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: CustomButton(
                          text: 'Send Code',
                          width: double.maxFinite,
                          // width: 45.0.wp,
                          height: 6.0.hp,
                          onTapHandler: () {
                            AuuthController.authInstance
                                .forgotPassword(emailController.text.trim());
                            // Get.to(() => PasswordResetVerificationScreen());
                            //forgetPassordHandler();
                          },
                          // fontSize: 12.0.sp,
                          fontSize: constructFontSize(context, 16),
                          borderRadius: 40,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: AppStyles.bgPrimary,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

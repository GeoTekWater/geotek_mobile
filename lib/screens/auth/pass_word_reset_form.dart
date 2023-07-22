import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/forgot_password.dart';
import 'package:geo_tek/screens/auth/password_reset_success_screen.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/card/custom_message_card.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:get/get.dart';

import '../../widgets/text/custom_formpassword_field.dart';

class PassworResetFormScreen extends StatefulWidget {
  const PassworResetFormScreen({super.key});

  @override
  State<PassworResetFormScreen> createState() => _PassworResetFormScreenState();
}

class _PassworResetFormScreenState extends State<PassworResetFormScreen> {
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Password Reset',
                color: AppStyles.bgPrimary,
                // size: 20.0.sp,
                size: constructFontSize(context, 25),
                weight: FontWeight.w100,
              ),
              SizedBox(height: 10.0.hp),
              CustomTextWidget(
                text: 'Please enter your new Password',
                color: AppStyles.bgBlack,
                // size: 13.0.sp,
                size: constructFontSize(context, 16),
              ),
              SizedBox(height: 2.0.hp),
              CustomFormPasswordField(
                controller: passwordController,
                hintText: 'Enter new password',
                fontColor: AppStyles.bgBlack,
                suffixIcon: const ImageIcon(
                  AssetImage('assets/icons/icon__eye.png'),
                ),
                showPassword: showPassword,
                background: Colors.white.withOpacity(0.4),
              ),
              SizedBox(height: 2.0.hp),
              CustomFormPasswordField(
                controller: passwordController,
                hintText: 'Confirm new password',
                fontColor: AppStyles.bgBlack,
                suffixIcon: const ImageIcon(
                  AssetImage('assets/icons/icon__eye.png'),
                ),
                showPassword: showPassword,
                background: Colors.white.withOpacity(0.4),
              ),
              SizedBox(height: 10.0.hp),
              Center(
                child: CustomButton(
                  text: 'Confirm',
                  // width: 40.0.wp,
                  width: double.maxFinite,
                  height: 6.0.hp,
                  onTapHandler: () {
                    Get.to(() => const PasswordResetSuccessScreen());
                  },
                  // fontSize: 14.0.sp,
                  fontSize: constructFontSize(context, 18),
                  fontColor: AppStyles.bgWhite,
                  fontWeight: FontWeight.bold,
                  borderRadius: 60,
                  backgroundColor: AppStyles.bgPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

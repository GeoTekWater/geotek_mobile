import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/auth/forgot_password.dart';
import 'package:geo_tek/screens/auth/successful_verification_screen.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/card/custom_message_card.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:get/get.dart';

import '../../widgets/text/custom_verification_text_form.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Get.off();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.0.hp),
              CustomTextWidget(
                text: 'Verification',
                color: AppStyles.bgPrimary,
                // size: 15.0.sp,
                size: constructFontSize(context, 25),
                weight: FontWeight.w200,
              ),
              CustomTextWidget(
                text: 'A verification code was sent to Emeka@gmail.com',
                color: AppStyles.bgBlack,
                // size: 12.0.sp,
                size: constructFontSize(context, 16),
              ),
              SizedBox(
                height: 5.0.hp,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomVerificationFormTextField(
                      maxLines: 1,
                      hintColor: AppStyles.bgBlack,
                      borderRadius: 15,
                      textColor: AppStyles.bgBlack,
                    ),
                    CustomVerificationFormTextField(
                      maxLines: 1,
                      hintColor: AppStyles.bgBlack,
                      borderRadius: 15,
                      textColor: AppStyles.bgBlack,
                    ),
                    CustomVerificationFormTextField(
                      maxLines: 1,
                      hintColor: AppStyles.bgBlack,
                      borderRadius: 15,
                      textColor: AppStyles.bgBlack,
                    ),
                    CustomVerificationFormTextField(
                      maxLines: 1,
                      hintColor: AppStyles.bgBlack,
                      borderRadius: 15,
                      textColor: AppStyles.bgBlack,
                    ),
                  ]),
              SizedBox(
                height: 4.0.hp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: 'Code not recieved?',
                    // size: 12.0.sp,
                    size: constructFontSize(context, 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        transition: Transition.zoom,
                        duration: Duration(milliseconds: 500),
                        () => print('Forget Password?'),
                      );
                    },
                    child: CustomTextWidget(
                      text: 'Resend Code',
                      color: Colors.blue,
                      // size: 12.0.sp,
                      size: constructFontSize(context, 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0.hp),
              Center(
                child: CustomButton(
                    text: 'Verify',
                    // width: 40.0.wp,
                    width: double.maxFinite,
                    height: 6.0.hp,
                    onTapHandler: () {
                      Get.to(() => const SuccessfulVerificationScreen());
                    },
                    // fontSize: 14.0.sp,
                    fontSize: constructFontSize(context, 18),
                    fontColor: AppStyles.bgWhite,
                    fontWeight: FontWeight.bold,
                    borderRadius: 60,
                    backgroundColor: AppStyles.bgPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

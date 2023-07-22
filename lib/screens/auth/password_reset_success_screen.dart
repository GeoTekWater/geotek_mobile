// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class PasswordResetSuccessScreen extends StatefulWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  State<PasswordResetSuccessScreen> createState() =>
      _PasswordResetSuccessScreenState();
}

class _PasswordResetSuccessScreenState
    extends State<PasswordResetSuccessScreen> {
  void initializeTimeout() async {
    await Future.delayed(Duration(milliseconds: 3000));

    Get.to(() => AuthenticationScreen());
  }

  @override
  void initState() {
    super.initState();

    initializeTimeout();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFE1E6FF),
      body: Container(
        height: screenHeight,
        // color: AppStyles.bgBlack,
        padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CustomTextWidget(
                text: 'Your password has been reset successfully.',
                size: constructFontSize(context, 20),
              ),
            ),
            SizedBox(height: 6.0.hp),
            SvgPicture.asset('assets/icons/icon__verified.svg')
          ],
        ),
      ),
    );
  }
}

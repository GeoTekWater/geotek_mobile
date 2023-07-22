// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/sub_screen/contact_us_screen.dart';
import 'package:geo_tek/screens/sub_screen/home_Page.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class ContactUsSuccessScreen extends StatefulWidget {
  const ContactUsSuccessScreen({super.key});

  @override
  State<ContactUsSuccessScreen> createState() => _ContactUsSuccessScreenState();
}

class _ContactUsSuccessScreenState extends State<ContactUsSuccessScreen> {
  void initializeTimeout() async {
    await Future.delayed(Duration(milliseconds: 3000));

    Get.to(() => ContactUsScreen());
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
                alignment: TextAlign.center,
                text: 'Message Sent. Thank you for your question/observation.',
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

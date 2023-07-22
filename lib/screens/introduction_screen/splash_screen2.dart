// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

import 'onboarding_screen.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  void runTimeout() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.off(
      transition: Transition.fade,
      () => const OnBoardingScreen(),
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    super.initState();

    runTimeout();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/logo.svg'),
              CustomTextWidget(
                fontStyle: FontStyle.italic,
                text: '...happiness in every drop of water.',
                // size: 12.0.sp,
                size: constructFontSize(context, 16),
                color: AppStyles.bgPrimary.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

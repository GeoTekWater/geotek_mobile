// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/screens/introduction_screen/splash_screen1.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void runTimeout() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(
      transition: Transition.fade,
      duration: const Duration(milliseconds: 500),
      () => const SplashScreen1(),
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
        child: SizedBox(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/logo__2.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

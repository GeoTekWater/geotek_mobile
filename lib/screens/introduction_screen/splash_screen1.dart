// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/screens/introduction_screen/splash_screen2.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  void runTimeout() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    Get.off(
      transition: Transition.fade,
      duration: const Duration(milliseconds: 500),
      () => const SplashScreen2(),
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
      body: Container(
        height: screenHeight,
        color: AppStyles.bgPrimary,
        child: Center(),
      ),
    );
  }
}

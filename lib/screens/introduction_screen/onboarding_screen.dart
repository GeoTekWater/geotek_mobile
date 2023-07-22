// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:get/get.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/text/custom_text_widget.dart';
import '../auth/login_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppStyles.bgPrimary,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 12.0.hp,
                // padding: EdgeInsets.all(1.0.hp),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  color: AppStyles.bgWhite,
                  fit: BoxFit.contain,
                ),
              ),
              CustomTextWidget(
                fontStyle: FontStyle.italic,
                text: '...happiness in every drop of water.',
                // size: 12.0.sp,
                size: constructFontSize(context, 16),
                color: AppStyles.bgWhite.withOpacity(0.6),
              ),
              SizedBox(
                height: 5.0.hp,
              ),
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomTextWidget(
                    text:
                        'At Geotek, our mission is to develop practical and cutting-edge solutions to the issue of water shortage and to offer knowledge that will support groundwater management in sub-Saharan Africa. Water scarcity is a combined concern.',
                    // size: 13.0.sp,
                    size: constructFontSize(context, 20),
                    color: Colors.white,
                    // weight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25.0.hp,
              ),
              CustomButton(
                fontColor: AppStyles.bgPrimary,
                text: 'Get Started',
                width: 50.0.wp,
                height: 6.0.hp,
                onTapHandler: () {
                  Get.off(
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 2000),
                    () => const AuthenticationScreen(),
                  );
                },
                // fontSize: 12.0.sp,
                fontSize: constructFontSize(context, 18),
                borderRadius: 40,
                // fontColor: AppStyles.bgBlue,
                fontWeight: FontWeight.bold,
                backgroundColor: AppStyles.bgWhite,
              ),
              SizedBox(height: 3.0.hp),
            ],
          ),
        ),
      ),
    );
  }
}

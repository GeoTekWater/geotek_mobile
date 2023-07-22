// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/login_page.dart';
import 'package:geo_tek/screens/auth/signUp_screen.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 6.0.hp),
                Padding(
                  padding: EdgeInsets.all(1.0.hp),
                  child: Container(
                    height: 12.0.hp,
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 10, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color.fromARGB(255, 233, 231, 231),
                    ),
                    //color:Color.fromARGB(204, 238, 238, 238),
                    child: TabBar(
                      labelColor: AppStyles.bgWhite,
                      unselectedLabelColor: AppStyles.bgBlack,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppStyles.bgPrimary,
                      ),
                      indicatorPadding: EdgeInsets.symmetric(
                        horizontal: 7,
                        //vertical: 3,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      // indicatorColor: AppStyles.bgBlue,
                      controller: tabController,
                      tabs: [
                        Container(
                          height: 6.0.hp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // border: Border.all(color: AppStyles.bgBlue, width: 1),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomTextWidget(
                              text: "Login",
                              //color: Colors.white,
                              // size: 12.0.sp,
                              size: constructFontSize(context, 16),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // border: Border.all(color: AppStyles.bgBlue, width: 1),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomTextWidget(
                              text: "Sign Up",
                              // color: Colors.white,
                              // size: 12.0.sp,
                              size: constructFontSize(context, 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.65,
                  padding: EdgeInsets.only(top: 3.0.hp),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      LoginScreen(),
                      SignupScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

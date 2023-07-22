// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/sub_screen/about_us_screen.dart';
import 'package:geo_tek/screens/sub_screen/contact_us_screen.dart';
import 'package:geo_tek/screens/sub_screen/home_page.dart';
import 'package:geo_tek/screens/sub_screen/notifications_screen.dart';
import 'package:geo_tek/screens/sub_screen/profiles_screen.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final authStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: AppStyles.bgPrimary,
      width: screenWidth * 0.2,
      // width: 60.0.wp,
      //width: MediaQuery.of(context).size.width * 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: ListView(
        padding: EdgeInsets.only(top: 10.0.hp),
        children: [
          Container(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo__main.svg',
                  color: AppStyles.bgWhite,
                ),
                SizedBox(height: 1.0.hp),
                CustomTextWidget(
                  text: 'GeoTek',
                  color: AppStyles.bgWhite,
                  size: constructFontSize(context, 14),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0.hp,
          ),
          Divider(),
          ListTile(
            title: Icon(
              Icons.home_rounded,
              color: AppStyles.bgWhite,
            ),
            onTap: () {
              Get.to(() => HomeScreen());
              debugPrint('[HOMESCREEN]]');
            },
          ),

          ListTile(
            title: Icon(
              Icons.person,
              color: AppStyles.bgWhite,
            ),
            onTap: () {
              Get.to(() => ProfileScreen());
              debugPrint('[PROFILE SCREEN]');
            },
          ),
          ListTile(
            title: Icon(
              Icons.info,
              color: AppStyles.bgWhite,
            ),
            onTap: () {
              Get.to(() => AboutUsScreen());
              // Get.to(() => RewardsWalletScreen());
              debugPrint('[ABOUT US SCREEN]');
            },
          ),
          ListTile(
            // title: ImageIcon(
            //   AssetImage('assets/icons/icon__info.png'),
            //   color: AppStyles.bgPrimary,
            // ),
            title: Icon(
              Icons.comment,
              color: AppStyles.bgWhite,
            ),
            onTap: () {
              Get.to(() => ContactUsScreen());
              debugPrint('[APP-GUIDE]');
            },
          ),
          ListTile(
            title: Icon(
              Icons.notifications,
              color: AppStyles.bgWhite,
            ),
            onTap: () {
              Get.to(() => NotificationsScreen());
              debugPrint('[NOTIFICATION SCREEN]');
            },
          ),

          // ListTile(),
          // ListTile(),
          SizedBox(height: 10.0.hp),
          ListTile(
            title: Icon(
              Icons.logout,
              color: AppStyles.bgBrightRed,
            ),
            onTap: () async {
              debugPrint('[LOG OUT]');

              Get.to(() => AuthenticationScreen());
              // await authServices.signoutController();
            },
          ),
        ],
      ),
    );
  }
}

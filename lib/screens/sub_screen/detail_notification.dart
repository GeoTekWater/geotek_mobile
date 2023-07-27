// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/screens/sub_screen/borehole_notification_maintenance_history_screen.dart';

class NotificationDetailScreen extends StatefulWidget {
  final Map notification;
  const NotificationDetailScreen({super.key, required this.notification});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      backgroundColor: AppStyles.bgPrimaryBackground,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          padding: EdgeInsets.only(
            top: 4.0.hp,
            left: 4.0.wp,
          ),
          child: PageHeader(scaffoldKey: scaffoldKey),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomTextWidget(
                    text: 'Notification',
                    weight: FontWeight.bold,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 25),
                  ),
                ),
                SizedBox(height: 2.0.hp),
                Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 60,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    color: AppStyles.bgPrimaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomTextWidget(
                    alignment: TextAlign.center,
                    text: widget.notification['title'],
                    size: constructFontSize(context, 18),
                    color: AppStyles.bgPrimary,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.08,
        padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'View Borehole',
              width: screenWidth * 0.95,
              // width: 20.0.hp,
              height: 6.0.hp,
              onTapHandler: () {
                Get.to(
                  () => BoreHoleNotificationMaintenanceHistoryScreen(
                    boreHole: widget.notification,
                  ),
                );
              },
              fontSize: constructFontSize(context, 16),
              // fontSize: 12.0.sp,
              borderRadius: 10,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              backgroundColor: AppStyles.bgPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

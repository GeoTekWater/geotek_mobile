// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/data/index.dart';
import 'package:geo_tek/screens/sub_screen/detail_notification.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/card/notification_card.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            top: MediaQuery.of(context).size.height * 0.05,
            // top: 4.0.hp,
            left: 4.0.wp,
          ),
          child: PageHeader(scaffoldKey: scaffoldKey),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            // height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
            child: Column(
              children: [
                Center(
                  child: CustomTextWidget(
                    text: 'Notifications',
                    weight: FontWeight.bold,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 25),
                  ),
                ),
                Container(
                  height: screenHeight * 0.9,
                  child: ListView.builder(
                    itemCount: appNotifications.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                          index: index, notification: appNotifications[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

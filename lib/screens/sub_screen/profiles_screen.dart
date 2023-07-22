import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppStyles.bgPrimaryBackground,
      drawer: const SideBar(),
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
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 2.0.hp),
                // PageHeader(scaffoldKey: scaffoldKey),
                Align(
                  alignment: Alignment.center,
                  child: CustomTextWidget(
                    text: 'Profile',
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 25),
                    weight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0.hp),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      child: Image.asset(
                        "assets/images/Ellipse 4.png",
                        scale: 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppStyles.bgWhite,
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 15,
                            color: AppStyles.bgPrimary,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0.hp),
                Container(
                  height: 8.0.hp,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    vertical: 1.0.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppStyles.bgPrimaryLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Name',
                        size: constructFontSize(context, 16),
                        color: AppStyles.bgBlack,
                      ),
                      CustomTextWidget(
                        text: 'Emeka Ifele',
                        size: constructFontSize(context, 14),
                        color: AppStyles.bgBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.0.hp),
                Container(
                  height: 8.0.hp,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    vertical: 1.0.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppStyles.bgPrimaryLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Phone Number',
                        size: constructFontSize(context, 16),
                        color: AppStyles.bgBlack,
                      ),
                      CustomTextWidget(
                        text: '+23408138303723',
                        size: constructFontSize(context, 14),
                        color: AppStyles.bgBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.0.hp),
                Container(
                  height: 8.0.hp,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    vertical: 1.0.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppStyles.bgPrimaryLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Email',
                        size: constructFontSize(context, 16),
                        color: AppStyles.bgBlack,
                      ),
                      CustomTextWidget(
                        text: 'EmekaIfele@gmail.com',
                        size: constructFontSize(context, 14),
                        color: AppStyles.bgBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 8.0.hp,
                      width: 20.0.wp,
                      padding: EdgeInsets.symmetric(
                        vertical: 1.0.hp,
                        horizontal: 4.0.wp,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppStyles.bgPrimaryLight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'City',
                            size: constructFontSize(context, 16),
                            color: AppStyles.bgBlack,
                          ),
                          CustomTextWidget(
                            text: 'JOS',
                            size: constructFontSize(context, 14),
                            color: AppStyles.bgBlack,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8.0.hp,
                      width: 20.0.wp,
                      padding: EdgeInsets.symmetric(
                        vertical: 1.0.hp,
                        horizontal: 4.0.wp,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppStyles.bgPrimaryLight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'State',
                            size: constructFontSize(context, 16),
                            color: AppStyles.bgBlack,
                          ),
                          CustomTextWidget(
                            text: 'Plateau',
                            size: constructFontSize(context, 14),
                            color: AppStyles.bgBlack,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8.0.hp,
                      width: 20.0.wp,
                      padding: EdgeInsets.symmetric(
                        vertical: 1.0.hp,
                        horizontal: 4.0.wp,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppStyles.bgPrimaryLight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'Country',
                            size: constructFontSize(context, 16),
                            color: AppStyles.bgBlack,
                          ),
                          CustomTextWidget(
                            text: 'Nigeria',
                            size: constructFontSize(context, 14),
                            color: AppStyles.bgBlack,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0.hp),
                Container(
                  height: 13.0.hp,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppStyles.bgPrimaryLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomTextWidget(
                            text: 'Contributions',
                            size: constructFontSize(context, 16),
                            color: AppStyles.bgBlack),
                      ),
                      CustomTextWidget(
                        text: 'Boredhole Added:  4',
                        size: constructFontSize(context, 14),
                        color: AppStyles.bgBlack,
                      ),
                      CustomTextWidget(
                        text: 'Conditions Reports:  2',
                        size: constructFontSize(context, 14),
                        color: AppStyles.bgBlack,
                      ),
                    ],
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
              text: 'Update Profile',
              width: screenWidth * 0.95,
              // width: 20.0.hp,
              height: 6.0.hp,
              onTapHandler: () {
                // Get.to(
                //   () => BoreHoleMaintenanceHistoryScreen(
                //       boreHole: widget.boreHole),
                // );
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

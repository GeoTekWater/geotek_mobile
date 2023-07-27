// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/models/borehole_model.dart';
import 'package:geo_tek/screens/sub_screen/borehole/borehole_chart_screen.dart';
import 'package:geo_tek/screens/sub_screen/borehole/borehole_maintenance_history_screen.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class BoreholeInfoScreen extends StatefulWidget {
  final BoreHoleModel boreHole;
  const BoreholeInfoScreen({super.key, required this.boreHole});

  @override
  State<BoreholeInfoScreen> createState() => _BoreholeInfoScreenState();
}

class _BoreholeInfoScreenState extends State<BoreholeInfoScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
          width: screenWidth,
          child: Column(
            children: [
              // SizedBox(height: 4.0.hp),
              // PageHeader(scaffoldKey: scaffoldKey),
              Container(
                // margin: EdgeInsets.only(top: 4.0.hp),
                // height: 12.0.hp,
                width: screenWidth * 0.3,
                child: SvgPicture.asset('assets/images/logo.svg'),
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                weight: FontWeight.w600,
                text: '${widget.boreHole.boreholeID}',
                size: constructFontSize(context, 20),
              ),
              SizedBox(height: 4.0.hp),
              Container(
                height: screenHeight * 0.25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      '${widget.boreHole.image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 2.0.hp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/borehole__2.jpg',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/borehole__3.jpg',
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/borehole__4.jpg',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4.0.hp,
                        left: 10.0.wp,
                        right: 0,
                        bottom: 0,
                        child: CustomTextWidget(
                          text: 'See more',
                          color: AppStyles.bgWhite,
                          size: constructFontSize(context, 14),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppStyles.bgPrimary.withOpacity(0.08),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Location:',
                      color: AppStyles.bgBlack,
                      weight: FontWeight.w600,
                      size: constructFontSize(context, 18),
                    ),
                    CustomTextWidget(
                      text: '${widget.boreHole.address}',
                      color: AppStyles.bgBlack,
                      size: constructFontSize(context, 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppStyles.bgPrimary.withOpacity(0.08),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Water Quality:',
                      color: AppStyles.bgBlack,
                      weight: FontWeight.w600,
                      size: constructFontSize(context, 18),
                    ),
                    CustomTextWidget(
                      text: 'Good',
                      weight: FontWeight.w600,
                      color: AppStyles.bgBlue,
                      size: constructFontSize(context, 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppStyles.bgPrimary.withOpacity(0.08),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Pump Functionality:',
                      color: AppStyles.bgBlack,
                      weight: FontWeight.w600,
                      size: constructFontSize(context, 18),
                    ),
                    CustomTextWidget(
                      text: 'Good',
                      weight: FontWeight.w600,
                      color: AppStyles.bgBlue,
                      size: constructFontSize(context, 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.08,
        padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              text: 'Sensor Readings',
              width: screenWidth * 0.45,
              // width: 20.0.hp,
              height: 6.0.hp,
              onTapHandler: () {
                Get.to(
                  () => BoreHoleChartScreen(),
                );
              },
              fontSize: constructFontSize(context, 16),
              // fontSize: 12.0.sp,
              borderRadius: 40,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              backgroundColor: AppStyles.bgPrimary,
            ),
            CustomButton(
              text: 'Maintenance History',
              width: screenWidth * 0.45,
              // width: 20.0.hp,
              height: 6.0.hp,
              onTapHandler: () {
                Get.to(
                  () => BoreHoleMaintenanceHistoryScreen(
                      boreHole: widget.boreHole),
                );
              },
              fontSize: constructFontSize(context, 16),
              // fontSize: 12.0.sp,
              borderRadius: 40,
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

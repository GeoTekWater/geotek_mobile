import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/models/borehole_model.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class BoreHoleMaintenanceHistoryScreen extends StatefulWidget {
  final BoreHoleModel boreHole;
  const BoreHoleMaintenanceHistoryScreen({super.key, required this.boreHole});

  @override
  State<BoreHoleMaintenanceHistoryScreen> createState() =>
      _BoreHoleMaintenanceHistoryScreenState();
}

class _BoreHoleMaintenanceHistoryScreenState
    extends State<BoreHoleMaintenanceHistoryScreen> {
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
              CustomTextWidget(
                weight: FontWeight.w600,
                text: '${widget.boreHole.boreholeID}',
                size: constructFontSize(context, 20),
              ),
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
              SizedBox(height: 4.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppStyles.bgGray4.withOpacity(0.8),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle_rounded,
                      size: 10,
                    ),
                    SizedBox(width: 4.0.wp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Connecting rod was fixed.',
                          color: AppStyles.bgBlack,
                          weight: FontWeight.w600,
                          size: constructFontSize(context, 18),
                        ),
                        CustomTextWidget(
                          text: '(14th April, 2022)',
                          color: AppStyles.bgBlack,
                          size: constructFontSize(context, 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppStyles.bgGray4.withOpacity(0.8),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle_rounded,
                      size: 10,
                    ),
                    SizedBox(width: 4.0.wp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: '(14th April, 2022)',
                          color: AppStyles.bgBlack,
                          weight: FontWeight.w600,
                          size: constructFontSize(context, 18),
                        ),
                        CustomTextWidget(
                          text: '(15th April, 2022)',
                          color: AppStyles.bgBlack,
                          size: constructFontSize(context, 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(2.0.hp),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppStyles.bgGray4.withOpacity(0.8),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle_rounded,
                      size: 10,
                    ),
                    SizedBox(width: 4.0.wp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Suction pipe was serviced.',
                          color: AppStyles.bgBlack,
                          weight: FontWeight.w600,
                          size: constructFontSize(context, 18),
                        ),
                        CustomTextWidget(
                          text: '(23rd October, 2021)',
                          color: AppStyles.bgBlack,
                          size: constructFontSize(context, 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
              text: 'Go back',
              width: screenWidth * 0.95,
              // width: 20.0.hp,
              height: 6.0.hp,
              onTapHandler: () {
                Get.back();
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

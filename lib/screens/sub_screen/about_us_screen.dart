// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:get/get.dart';

import '../../widgets/text/custom_text_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppStyles.bgPrimaryBackground,
      drawer: SideBar(),
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
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.0.hp),
                Center(
                  child: CustomTextWidget(
                    text: 'About Us',
                    weight: FontWeight.bold,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 25),
                  ),
                ),
                // PageHeader(scaffoldKey: scaffoldKey),
                SizedBox(height: 2.0.hp),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'OUR MOTTO:',
                      weight: FontWeight.bold,
                      color: AppStyles.bgPrimary,
                      size: constructFontSize(context, 20),
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0.wp),
                      color: AppStyles.bgPrimaryLight,
                      child: CustomTextWidget(
                        fontStyle: FontStyle.italic,
                        color: AppStyles.bgPrimary,
                        text: '...happiness in every drop of water.',
                        size: constructFontSize(context, 18),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.hp,
                    ),
                    CustomTextWidget(
                        text: 'WHO WE ARE',
                        color: AppStyles.bgPrimary,
                        size: constructFontSize(context, 20),
                        weight: FontWeight.bold),
                    Container(
                      padding: EdgeInsets.all(2.0.wp),
                      color: AppStyles.bgPrimaryLight,
                      child: CustomTextWidget(
                        fontStyle: FontStyle.italic,
                        lineHeight: 2,
                        text:
                            'Founded by individuals passionate about addressing water scarcity in sub-Saharan Africa. Our research-driven approach has led to the development of innovative tools that monitor water infrastructures, such as boreholes and hand pumps. These tools ensure sustainable access to clean water in regions most threatened by freshwater depletion.',
                        color: AppStyles.bgPrimary,
                        size: constructFontSize(context, 18),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.hp,
                    ),
                    CustomTextWidget(
                      text: 'OUR MISSION',
                      color: AppStyles.bgPrimary,
                      size: constructFontSize(context, 20),
                      weight: FontWeight.bold,
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0.wp),
                      color: AppStyles.bgPrimaryLight,
                      child: CustomTextWidget(
                        fontStyle: FontStyle.italic,
                        lineHeight: 2,
                        color: AppStyles.bgPrimary,
                        text:
                            'At Geotek, our mission is to develop practical and cutting-edge solutions to the issue of water ',
                        size: constructFontSize(context, 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

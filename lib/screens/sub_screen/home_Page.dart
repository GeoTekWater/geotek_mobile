// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/sub_screen/add_water_system_screen.dart';
import 'package:geo_tek/screens/sub_screen/groundwater_survey_screen.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:get/get.dart';

import '../map/map_interface_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddWaterSystemScreen());
        },
        backgroundColor: AppStyles.bgPrimary,
        child: Text(
          'Report',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppStyles.bgWhite,
              child: MapInterface(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              left: 2.0.wp,
              width: screenWidth,
              child: PageHeader(scaffoldKey: scaffoldKey),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              right: 4.0.wp,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                elevation: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Get.to(() => const GroundwaterSurveyScreen());
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.science_outlined,
                      color: AppStyles.bgPrimary,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

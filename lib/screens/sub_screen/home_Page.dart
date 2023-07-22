// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';

import '../map/main_map.dart';

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
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color:AppStyles.bgBlack
      //   ),
      //   backgroundColor: AppStyles.bgWhite,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Container(
            color: AppStyles.bgWhite,
            child: MainMap(),
          ),
          Positioned(
            top: 4.0.hp,
            left: 2.0.wp,
            width: screenWidth,
            child: PageHeader(scaffoldKey: scaffoldKey),
          ),
        ],
      ),
    );
  }
}

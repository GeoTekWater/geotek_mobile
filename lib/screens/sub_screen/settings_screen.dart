// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:get/get.dart';

import '../../config/app_config.dart';
import '../../widgets/buttons/custom_button.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              //PageHeader(scaffoldKey: scaffoldKey),
              Expanded(
                  child: Center(
                    child: CustomButton(
                      text: 'next KYC', 
                      width: 10.0.wp, 
                      height: 3.0.hp, 
                      onTapHandler: (){
                      }, 
                      fontSize: 15,
                      fontColor: Colors.white, 
                      fontWeight: FontWeight.bold, 
                      borderRadius: 30,backgroundColor: AppStyles.bgBlue,),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

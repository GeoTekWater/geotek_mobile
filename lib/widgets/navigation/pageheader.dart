// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_tek/config/app_config.dart';

class PageHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const PageHeader({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 4.0.hp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1,
                  spreadRadius: 1,
                )
              ],
            ),
            child: GestureDetector(
              onTap: () {
                // Scaffold.of(context).openDrawer();
                // SideBar();
                scaffoldKey.currentState!.openDrawer();
              },
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo__main.svg',
                  color: AppStyles.bgPrimary,
                ),
              ),
              // icon: Icon(
              //   Icons.menu,
              //   color: AppStyles.bgBlack,
              // ),
            ),
          ),

          // Container(
          //   width: 80,
          //   height: 40,
          //   child: SvgPicture.asset('assets/images/logo.svg'),
          // )
        ],
      ),
    );
  }
}

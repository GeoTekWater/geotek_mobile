//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';

import '../buttons/custom_button.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  late final double borderRadius;
  late final String text;
  late final String text1;
  late final double width;
  late final double height;
  late final Color fontColor;
  late final double fontSize;
  late final Color color;
  final Function onTapHandler;
    final FontWeight fontWeight;
  final Color backgroundColor;
  String? type;
  CustomCard({
    super.key,
    this.type,
    required this.color,
    required this.text,
    required this.text1,
    required this.onTapHandler,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.fontColor,
    required this.borderRadius,
    required this.backgroundColor,
    required this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
    //   width: width,
    //   height: height,
    //   margin: type == 'list'
    //       ? EdgeInsets.only(right: AppLayout.getWidth(10))
    //       : const EdgeInsets.all(0),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     border: Border.all(color: color),
    //     borderRadius: BorderRadius.circular(borderRadius),
    //   ),
    //   child: 
      Container(
        height: 200,
        child: Card(
          
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              borderOnForeground: true,
              shadowColor: AppStyles.bgPrimary,
              elevation: 10,
              color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
            CustomTextWidget(
              text: text,
              color: fontColor,
              size: fontSize,
            ),
        
            CustomTextWidget(
              text: text1,
              color: fontColor,
              size: fontSize,
            ),
            
            //SizedBox(height: 2.0.hp),
            CustomButton(
              text: text, 
              width: width, 
              height: height, 
              onTapHandler: onTapHandler, 
              fontSize: fontSize, 
              fontColor: fontColor, 
              fontWeight: fontWeight, 
              borderRadius: borderRadius, 
              backgroundColor: backgroundColor
            )
          ]),
     // ),
    ),
      );
  }
}



// Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ImageIcon(
//                 AssetImage('assets/icons/icon__verified__1.png'),
//                 color: AppStyles.bgBlue,
//                 size: 80.0.sp,
//               ),
//               SizedBox(height: 2.0.hp),
//               CustomTextWidget(
//                 text: 'Success',
//                 color: Colors.white,
//               ),
//               SizedBox(height: 2.0.hp),
//               CustomButton(
//                 text: 'Back to Login',
//                 width: double.maxFinite,
//                 height: 6.0.hp,
//                 onTapHandler: () {
//                   Get.to(() => LoginScreen());
//                 },
//                 fontSize: 12.0.sp,
//                 borderRadius: 5,
//                 fontColor: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 backgroundColor: AppStyles.bgPrimary,
//               ),
//             ],
//           ),

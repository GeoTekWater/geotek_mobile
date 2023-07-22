// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final String text;
  final double width;
  final double height;
  final Function onTapHandler;
  final Color fontColor;
  final double fontSize;
  Color? borderColor;
  final FontWeight fontWeight;
  final Color backgroundColor;
  String? type;
  CustomButton({
    super.key,
    this.type,
    this.borderColor,
    required this.text,
    required this.width,
    required this.height,
    required this.onTapHandler,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.borderRadius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapHandler();
      },
      child: Container(
        width: width,
        height: height,
        margin: type == 'list'
            ? EdgeInsets.only(right: AppLayout.getWidth(10))
            : EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: CustomTextWidget(
            text: text,
            color: fontColor,
            size: fontSize,
            weight: fontWeight,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';

class CustomVerificationFormTextField extends StatelessWidget {
  String? hintText;
  // ignore: prefer_typing_uninitialized_variables
  var maxLines;
  bool? readOnly;
  Color? textColor;
  Color? background;
  Color? hintColor;
  double? height;
  double? paddingTop;
  int? maxLength;
  double? paddingLeft;
  double? paddingRight;
  double? borderRadius;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  CustomVerificationFormTextField({
    super.key,
    this.prefixIcon,
    this.height,
    this.background,
    this.textColor,
    this.paddingTop,
    this.maxLength,
    this.paddingLeft,
    this.paddingRight,
    this.readOnly,
    this.hintText,
    this.controller,
    this.borderRadius,
    this.keyboardType,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.0.wp,
      height: height ?? 7.0.hp,
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.blue.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        // boxShadow: [
        //   BoxShadow(color: AppStyles.bgWhite, blurRadius: 2, spreadRadius: 1)
        // ],
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            offset: Offset(
              0,
              2.0,
            ),
            blurRadius: 4,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          readOnly: readOnly ?? false,
          maxLines: maxLines,
          maxLength: maxLength ?? 1,
          controller: controller ?? controller,
          keyboardType: keyboardType ?? TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? '',
            contentPadding: EdgeInsets.only(
              left: paddingLeft ?? 20,
              right: paddingRight ?? 0,
              top: paddingTop ?? 0,
            ),
            counterText: "",
            // prefixIcon: prefixIcon ?? prefixIcon,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: constructFontSize(context, 20),
            ),
          ),
          style: TextStyle(
            fontSize: constructFontSize(context, 20),
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

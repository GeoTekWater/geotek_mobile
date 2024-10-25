// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';

class CustomFormTextField extends StatelessWidget {
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
  Color? borderColor;
  double? fontSize;
  ImageIcon? prefixIcon;
  TextInputAction? inputAction;
  TextEditingController? controller;
  TextInputType? keyboardType;
  CustomFormTextField({
    super.key,
    this.prefixIcon,
    this.height,
    this.inputAction,
    this.background,
    this.textColor,
    this.paddingTop,
    this.borderColor,
    this.maxLength,
    this.paddingLeft,
    this.paddingRight,
    this.readOnly,
    this.hintText,
    this.controller,
    this.borderRadius,
    this.fontSize,
    this.keyboardType,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height ?? 6.0.hp,
      decoration: BoxDecoration(
        color: background ?? background,
        border: Border.all(
          color: borderColor ?? AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        maxLength: maxLength ?? 255,
        controller: controller ?? controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textInputAction: inputAction ?? TextInputAction.next,
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
            fontSize: fontSize ?? constructFontSize(context, 14),
          ),
        ),
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? constructFontSize(context, 14),
        ),
      ),
    );
  }
}

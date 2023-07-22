// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  String? icon;
  bool? focusKeyboard;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Function? onChangeHandler;
  CustomSearchField({
    super.key,
    this.icon,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.focusKeyboard,
    this.onChangeHandler,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
      height: 6.0.hp,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 2),
            child: ImageIcon(
              AssetImage("$icon"),
              color: AppStyles.bgBlack,
            ),
          ),
          SizedBox(width: 2.0.wp),
          Container(
            margin: EdgeInsets.only(bottom: 0.5.hp),
            width: 80.0.wp,
            child: TextFormField(
              autofocus: focusKeyboard ?? false,
              onChanged: (String value) {
                onChangeHandler!(value);
              },
              controller: controller ?? controller,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardType ?? TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                //contentPadding: EdgeInsets.all(15),
                // prefixIcon: prefixIcon ?? prefixIcon,
                hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: AppStyles.bgGray,
                ),
              ),
              style: TextStyle(
                color: AppStyles.bgBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

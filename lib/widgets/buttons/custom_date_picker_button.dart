// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';

class CustomDatePickerButton extends StatefulWidget {
  double? height;
  DateTime date;
  double? borderRadius;
  final TextEditingController controller;
  CustomDatePickerButton({
    super.key,
    this.height,
    this.borderRadius,
    required this.date,
    required this.controller,
  });

  @override
  State<CustomDatePickerButton> createState() => _CustomDatePickerButtonState();
}

class _CustomDatePickerButtonState extends State<CustomDatePickerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: widget.height ?? 6.0.hp,
      padding: EdgeInsets.only(
        left: 4.0.wp,
        right: 4.0.wp,
      ),
      decoration: BoxDecoration(
        color: AppStyles.bgWhite,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        border: Border.all(
          color: AppStyles.bgBlack.withOpacity(0.5),
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: widget.date,
            firstDate: DateTime(1985),
            lastDate: DateTime(2030),
          );

          if (newDate == null) return;
          debugPrint('[NEW-DATE] :: $newDate');
          setState(() {
            widget.date = DateTime(newDate.year, newDate.month, newDate.day);
            widget.controller.text = newDate.toString();
          });
          debugPrint('[NEW-DATE-] :: ${widget.controller.text}');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.0.wp,
              // width: double.maxFinite,
              margin: EdgeInsets.only(
                left: 2.0.wp,
              ),
              child: CustomTextWidget(
                text: widget.controller.text.substring(0, 10),
                size: 12.0.sp,
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:geo_tek/config/app_config.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  Color? color;
  double? size;
  int? maxLines;
  double? lineHeight;
  FontWeight? weight;
  FontStyle? fontStyle;
  TextAlign? alignment;

  CustomTextWidget({
    super.key,
    this.color,
    this.size,
    this.maxLines,
    this.weight,
    this.fontStyle,
    this.lineHeight,
    this.alignment,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 10,
      textAlign: alignment ?? TextAlign.left,
      style: TextStyle(
        fontStyle: fontStyle ?? FontStyle.normal,
        color: color,
        height: lineHeight ?? 0,
        fontSize: size ?? 16.0.sp,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}

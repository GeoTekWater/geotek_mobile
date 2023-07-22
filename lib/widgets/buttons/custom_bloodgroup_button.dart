// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';

class CustomBloodGroupButton extends StatefulWidget {
  final List items;
  String currentItem;
  final Function onChangeHandler;
  CustomBloodGroupButton({
    super.key,
    required this.items,
    required this.currentItem,
    required this.onChangeHandler,
  });

  @override
  State<CustomBloodGroupButton> createState() => _CustomBloodGroupButtonState();
}

class _CustomBloodGroupButtonState extends State<CustomBloodGroupButton> {
  void onTapHandler() {
    showModalBottomSheet(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        context: context,
        builder: (builder) {
          return Container(
            height: 40.0.hp,
            padding: EdgeInsets.symmetric(
              vertical: 4.0.hp,
              horizontal: 4.0.wp,
            ),
            decoration: BoxDecoration(
              color: AppStyles.bgWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Blood group',
                  size: 14.0.sp,
                ),
                SizedBox(height: 2.0.hp),
                Expanded(
                  // height: 35.0.hp,
                  child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              widget.currentItem = widget.items[index]['name'];
                            });
                            widget.onChangeHandler(index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 3.0.hp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextWidget(
                                  text: widget.items[index]['name'],
                                  size: 14.0.sp,
                                ),
                                Container(
                                  width: 2.0.hp,
                                  height: 2.0.hp,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppStyles.bgBlack),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: widget.currentItem ==
                                            widget.items[index]['name']
                                        ? Container(
                                            width: 1.0.hp,
                                            height: 1.0.hp,
                                            decoration: BoxDecoration(
                                              color: AppStyles.bgBlack,
                                              border: Border.all(
                                                  color: AppStyles.bgBlack),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        width: double.maxFinite,
        height: 6.5.hp,
        padding: EdgeInsets.only(
          left: 4.0.wp,
          right: 4.0.wp,
        ),
        decoration: BoxDecoration(
          color: AppStyles.bgWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppStyles.bgBlack.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              text: widget.currentItem == '' ? '-' : widget.currentItem,
              size: 12.0.sp,
              color: AppStyles.bgBlack,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppStyles.bgBlack,
            ),
          ],
        ),
      ),
    );
  }
}

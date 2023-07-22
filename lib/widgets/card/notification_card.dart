import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/sub_screen/detail_notification.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class NotificationCard extends StatelessWidget {
  final int index;
  final Map notification;
  const NotificationCard({
    super.key,
    required this.index,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0.hp),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppStyles.bgPrimary.withOpacity(0.5)),
        ),
      ),
      child: ListTile(
        onTap: () {
          Get.to(() => NotificationDetailScreen(notification: notification));
        },
        leading: Image.asset(
          'assets/icons/icon__marker.png',
          width: constructFontSize(context, 20),
        ),
        title: CustomTextWidget(
          text: '${notification['title']}',
          size: constructFontSize(context, 16),
        ),
        trailing: CustomTextWidget(
          text: '',
          color: Colors.white,
          size: 6.0.sp,
        ),
      ),
    );
  }
}

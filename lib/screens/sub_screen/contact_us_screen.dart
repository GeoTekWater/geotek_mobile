// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/sub_screen/contact_us_success_screen.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/card/custom_message_card.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:get/get.dart';

import '../../data/social_media_Index.dart';
import '../../sidebar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            // top: 4.0.hp,
            left: 4.0.wp,
          ),
          child: PageHeader(scaffoldKey: scaffoldKey),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomTextWidget(
                    text: 'Contact Us',
                    weight: FontWeight.bold,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 25),
                  ),
                ),
                // SizedBox(height: 2.0.hp),
                // PageHeader(scaffoldKey: scaffoldKey),
                SizedBox(height: 8.0.hp),
                CustomTextWidget(
                  text: 'Title',
                  size: constructFontSize(context, 18),
                  weight: FontWeight.bold,
                  alignment: TextAlign.center,
                  color: AppStyles.bgPrimary,
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  maxLines: 1,
                  background: AppStyles.bgPrimaryLight,
                  borderColor: AppStyles.bgPrimaryLight,
                  hintColor: AppStyles.bgBlack,
                  hintText: 'Title',
                  borderRadius: 10,
                ),
                SizedBox(height: 4.0.hp),
                CustomTextWidget(
                  text: 'Body',
                  size: constructFontSize(context, 18),
                  weight: FontWeight.bold,
                  alignment: TextAlign.center,
                  color: AppStyles.bgPrimary,
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  hintText: 'Message',
                  maxLines: 6,
                  paddingTop: 1.0.hp,
                  paddingLeft: 2.0.wp,
                  paddingRight: 2.0.wp,
                  height: 14.0.hp,
                  borderRadius: 10,
                  borderColor: AppStyles.bgPrimaryLight,
                  textColor: AppStyles.bgBlack,
                  controller: messageController,
                  background: AppStyles.bgPrimaryLight,
                  hintColor: AppStyles.bgBlack,
                ),
                SizedBox(height: 6.0.hp),
                CustomButton(
                  text: 'Submit',
                  width: double.maxFinite,
                  height: 6.0.hp,
                  onTapHandler: () async {
                    Get.to(() => ContactUsSuccessScreen());

                    if (subjectController.text.trim() == '') {
                      Get.snackbar(
                        'Error',
                        'Subject is required',
                        colorText: Colors.white,
                        backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                      );
                    }
                    if (messageController.text.trim() == '') {
                      Get.snackbar(
                        'Error',
                        'Message is required',
                        colorText: Colors.white,
                        backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                      );
                    }
                    // Map formData = {
                    //   "subject": subjectController.text.trim(),
                    //   "message": messageController.text.trim()
                    // };
                  },
                  fontSize: 12.0.sp,
                  borderRadius: 25,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: AppStyles.bgPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   launchSocialMedia({required String url}) async {
//     var urllaunchable = await canLaunchUrl(
//         Uri.parse(url)); //canLaunch is from url_launcher package
//     if (urllaunchable) {
//       await launchUrl(
//         Uri.parse(url),
//       ); //launch is from url_launcher package to launch URL
//     } else {
//       debugPrint("URL can't be launched.");
//     }
//   }
// }

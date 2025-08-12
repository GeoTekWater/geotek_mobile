// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/sub_screen/contact_us_success_screen.dart';
import 'package:geo_tek/screens/sub_screen/home_Page.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/card/custom_message_card.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/social_media_Index.dart';
import '../../sidebar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  RxBool isSendEmailProcessing = false.obs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  void submitHandler() async {
    isSendEmailProcessing.value = true;

    if (!emailController.text.trim().isNotEmpty ||
        !messageController.text.trim().isNotEmpty ||
        !lastNameController.text.trim().isNotEmpty ||
        !firstNameController.text.trim().isNotEmpty) {
      isSendEmailProcessing.value = false;

      Get.snackbar(
        "Error",
        "Please ensure you fill in fields in the form as the are required ",
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        duration: const Duration(milliseconds: 3500),
      );
    } else if (!emailController.text.isEmail) {
      isSendEmailProcessing.value = false;

      Get.snackbar(
        "Error",
        "Invalid Email address",
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        duration: const Duration(milliseconds: 3500),
      );
    } else {
      Dio dio = Dio();
      FirebaseAuth auth = FirebaseAuth.instance;

      Map data = {
        "email": emailController.text.trim().toLowerCase(),
        "firstName": firstNameController.text.trim().toLowerCase(),
        "lastName": lastNameController.text.trim(),
        "message": "GEOTEK: ${messageController.text.trim()}"
      };

      final res = await dio.post(
        "https://livestocx.xyz/api/v1/notifications/contact-us",
        data: data,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.snackbar(
          "Message",
          "Thank you for contacting us, we will reach out to you shortly.",
          colorText: AppStyles.bgWhite,
          backgroundColor: AppStyles.bgPrimary.withOpacity(0.5),
          duration: const Duration(milliseconds: 6500),
        );

        isSendEmailProcessing.value = false;

        setState(() {
          subjectController.clear();
          messageController.clear();
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
        });

        debugPrint("[DISPATCH-CONTACT-US-NOTIFICATION-SUCCESS]");
      } else {
        isSendEmailProcessing.value = false;

        Get.snackbar(
          "Message",
          "An error occurred please try again!.",
          colorText: AppStyles.bgWhite,
          backgroundColor: AppStyles.bgPrimary.withOpacity(0.5),
          duration: const Duration(milliseconds: 6500),
        );
      }
    }
    // Map formData = {
    //   "subject": subjectController.text.trim(),
    //   "message": messageController.text.trim()
    // };
  }

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
                Center(
                  child: CustomTextWidget(
                    text: 'Send Us A Message',
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomFormTextField(
                  hintText: 'First Name',
                  controller: firstNameController,
                  maxLines: 1,
                  height: 50,
                  borderRadius: 5,
                  textColor: AppStyles.bgBlack,
                  hintColor: AppStyles.bgGray,
                ),
                const SizedBox(height: 10),
                CustomFormTextField(
                  hintText: 'Last Name',
                  controller: lastNameController,
                  maxLines: 1,
                  height: 50,
                  borderRadius: 5,
                  textColor: AppStyles.bgBlack,
                  hintColor: AppStyles.bgGray,
                ),
                const SizedBox(height: 10),
                CustomFormTextField(
                  hintText: 'Email',
                  controller: emailController,
                  maxLines: 1,
                  height: 50,
                  borderRadius: 5,
                  textColor: AppStyles.bgBlack,
                  hintColor: AppStyles.bgGray,
                ),
                const SizedBox(height: 10),

                CustomFormTextField(
                  hintText: 'Message',
                  maxLines: 6,
                  paddingTop: 1.0.hp,
                  paddingLeft: 2.0.wp,
                  paddingRight: 2.0.wp,
                  height: 14.0.hp,
                  borderRadius: 5,
                  borderColor: AppStyles.bgGray,
                  textColor: AppStyles.bgBlack,
                  controller: messageController,
                  // background: AppStyles.bgPrimaryLight,
                  hintColor: AppStyles.bgBlack,
                ),
                SizedBox(height: 6.0.hp),
                Obx(() {
                  return isSendEmailProcessing.isTrue
                      ? Container(
                          height: 6.0.hp,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppStyles.bgPrimary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: AppStyles.bgWhite, size: 30),
                          ),
                        )
                      : CustomButton(
                          text: 'Submit',
                          width: double.maxFinite,
                          height: 6.0.hp,
                          onTapHandler: submitHandler,
                          fontSize: 12.0.sp,
                          borderRadius: 25,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: AppStyles.bgPrimary,
                        );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  width: double.maxFinite,
                  child: Image.asset(
                    'assets/images/illustration__contact_us__1.png',
                  ),
                ),
                const SizedBox(height: 20),
                // GIVE US A CALL CARD
                Container(
                  height: 180,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppStyles.bgWhite,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: AppStyles.bgGray.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.phoneCall,
                        color: AppStyles.bgBlue,
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        size: 18,
                        weight: FontWeight.w500,
                        color: AppStyles.bgPrimary,
                        text: 'Give us a call today!',
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        size: 18,
                        text: '+234 (0) 9013108404',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // CONNECT WITH US
                Container(
                  height: 180,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppStyles.bgWhite,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: AppStyles.bgGray.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.phoneCall,
                        color: AppStyles.bgBlue,
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        size: 18,
                        weight: FontWeight.w500,
                        color: AppStyles.bgPrimary,
                        text: 'Connect with us!',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  "https://web.facebook.com/p/Geotek-100063586226079");

                              try {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                    // webViewConfiguration: WebViewConfiguration()
                                  );
                                } else {
                                  throw 'Could not launch $url';
                                }
                              } catch (error) {
                                debugPrint('[ERROR] :: ${error.toString()}');
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppStyles.bgPrimary,
                              child: Image.asset(
                                'assets/icons/icon__facebook.png',
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  "https://www.linkedin.com/company/geotekwater");

                              try {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                    // webViewConfiguration: WebViewConfiguration()
                                  );
                                } else {
                                  throw 'Could not launch $url';
                                }
                              } catch (error) {
                                debugPrint('[ERROR] :: ${error.toString()}');
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppStyles.bgPrimary,
                              child: Image.asset(
                                'assets/icons/icon__linkedin.png',
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  "https://www.instagram.com/geotek_water");

                              try {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                    // webViewConfiguration: WebViewConfiguration()
                                  );
                                } else {
                                  throw 'Could not launch $url';
                                }
                              } catch (error) {
                                debugPrint('[ERROR] :: ${error.toString()}');
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppStyles.bgPrimary,
                              child: Image.asset(
                                'assets/icons/icon__instagram.png',
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 180,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppStyles.bgWhite,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: AppStyles.bgGray.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.mail,
                        color: AppStyles.bgBlue,
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        size: 18,
                        weight: FontWeight.w500,
                        color: AppStyles.bgPrimary,
                        text: 'Send us an email',
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        size: 18,
                        text: 'info@geotek.com.ng',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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

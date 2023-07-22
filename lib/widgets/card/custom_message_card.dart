// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/text/custom_formpassword_field.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import '../../screens/sub_screen/home_page.dart';

class CustomContactSuccessCard extends StatefulWidget {
  const CustomContactSuccessCard({super.key});

  @override
  State<CustomContactSuccessCard> createState() =>_CustomContactSuccessCardState();
}
class _CustomContactSuccessCardState extends State<CustomContactSuccessCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 50.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Color.fromARGB(255, 190, 186, 241),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.0.hp),
                  Padding(
                    padding:  EdgeInsets.only(top:4.0, bottom: 4.0),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'Message Sent. Thank you for your question/ observation.',
                        size: 13.0.sp,
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/icon__verified__1.png'),
                      color: AppStyles.bgPrimary,
                      size: 80.0.sp,
                    ),
                  ),  
                ],
              ),
          ),
        ),
    );
  }
}


class CustomSentSuccessCard extends StatefulWidget {
  const CustomSentSuccessCard({super.key});

  @override
  State<CustomSentSuccessCard> createState() =>_CustomSentSuccessCardState();
}
class _CustomSentSuccessCardState extends State<CustomSentSuccessCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 50.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Color.fromARGB(255, 190, 186, 241),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.0.hp),
                  Padding(
                    padding:  EdgeInsets.only(top:4.0, bottom: 4.0),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'Sent Successfully! \nplease check your\n\t\t\t\t\t\t\t\t\t\t\t\temail',
                        size: 13.0.sp,
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/icon__verified__1.png'),
                      color: AppStyles.bgPrimary,
                      size: 80.0.sp,
                    ),
                  ),  
                ],
              ),
          ),
        ),
    );
  }
}

class CustomResetSuccessCard extends StatefulWidget {
  const CustomResetSuccessCard({super.key});

  @override
  State<CustomResetSuccessCard> createState() =>_CustomResetSuccessCardState();
}
class _CustomResetSuccessCardState extends State<CustomResetSuccessCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 85.0.wp,
          height: 60.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Color.fromARGB(255, 190, 186, 241),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.0.hp),
                  Padding(
                    padding:  EdgeInsets.all(4.0.hp),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'Your password has been reset successfully',
                        size: 13.0.sp,
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/icon__verified__1.png'),
                      color: AppStyles.bgPrimary,
                      size: 80.0.sp,
                    ),
                  ), 
                  
                   SizedBox(height: 5.0.hp,),
                   CustomButton(
                    text: 'Go to Dashboard', 
                    width: 60.0.wp, 
                    height: 6.0.hp, 
                    onTapHandler: (){
                      Get.to(()=>HomeScreen());
                    }, fontSize: 15.0.sp, 
                    fontColor: AppStyles.bgWhite, 
                    fontWeight: FontWeight.bold, 
                    borderRadius: 30.0.wp, 
                    backgroundColor: AppStyles.bgPrimary
                   )
                ],
              ),
          ),
        ),
    );
  }
}


class CustomSuccessCard extends StatefulWidget {
  const CustomSuccessCard({super.key});

  @override
  State<CustomSuccessCard> createState() =>_CustomSuccessCardState();
}
class _CustomSuccessCardState extends State<CustomSuccessCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 50.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Color.fromARGB(255, 190, 186, 241),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.0.hp),
                  Padding(
                    padding:  EdgeInsets.only(top:8.0, left: 4.0.hp),
                    child: CustomTextWidget(
                      text: 'You have been verified successfully',
                      size: 13.0.sp,
                      ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/icon__verified__1.png'),
                      color: AppStyles.bgPrimary,
                      size: 80.0.sp,
                    ),
                  ),
                  SizedBox(height: 5.0.hp),
                  CustomTextWidget(
                    text: 'Thank you for choosing us',
                    color: AppStyles.bgBlack,
                    size: 13.0.sp,
                  ),
                  SizedBox(height: 2.0.hp),
                  
                ],
              ),
          ),
        ),
    );
  }
}

class CustomFailedCard extends StatefulWidget {
  const CustomFailedCard({super.key});

  @override
  State<CustomFailedCard> createState() =>_CustomFailedCardState();
}
class _CustomFailedCardState extends State<CustomFailedCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 50.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/icon__verified__1.png'),
                      color: AppStyles.bgBlue,
                      size: 80.0.sp,
                    ),
                  ),
                  SizedBox(height: 2.0.hp),
                  CustomTextWidget(
                    text: 'Error',
                    color: AppStyles.bgBlack,
                  ),
                  SizedBox(height: 2.0.hp),
                  
                ],
              ),
          ),
        ),
    );
  }
}

class CustomScheduleCard extends StatefulWidget {
  const CustomScheduleCard({super.key});

  @override
  State<CustomScheduleCard> createState() =>_CustomScheduleCardState();
}
class _CustomScheduleCardState extends State<CustomScheduleCard> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 60.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.0.wp,
                    height: 10.0.hp,
                    child: Image.asset('assets/images/logo__1.png'),
                  ),
                  SizedBox(height: 2.0.hp),
                  Padding(
                    padding: EdgeInsets.only(left:8.0.wp),
                    child: CustomTextWidget(
                      text: 'By scheduling an appointment, you \nagree to send necessary information\nabout you to the donation center',
                      color: AppStyles.bgBlack,
                      size: 15.0.sp,
                    ),
                  ),
                  SizedBox(height: 2.0.hp),

                  Padding(
                    padding: EdgeInsets.only(left:8.0.hp,right: 8.0.hp),
                    child: CustomButton(
                      text: 'Good to go!', 
                      width: double.maxFinite,
                      height: 6.0.hp, 
                      fontSize: 15.0.sp, 
                      fontColor: Colors.white, 
                      fontWeight:FontWeight.normal, 
                      borderRadius: 20, 
                      backgroundColor: AppStyles.bgBlue, 
                      onTapHandler: (){},
                    ),
                  ),  
                ],
              ),
          ),
        ),
    );
  }
}

class CustomClaimCard extends StatefulWidget {
  const CustomClaimCard({super.key});

  @override
  State<CustomClaimCard> createState() =>_CustomClaimCardState();
}
class _CustomClaimCardState extends State<CustomClaimCard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 100.0.wp,
          height: 80.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgPrimary,
            elevation: 10,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0.wp,
                    height: 10.0.hp,
                    child: Image.asset('assets/images/logo__1.png'),
                  ),
                  SizedBox(height: 2.0.hp),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      CustomTextWidget(
                        text: 'Claim Your Cash Reward',
                        color: AppStyles.bgBlack,
                        weight: FontWeight.bold,
                      ),
                      CustomTextWidget(
                        text: 'Fill in your account details',
                        color: AppStyles.bgBlack,
                        size: 13.0.sp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0.hp),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: accountNameController,
                          decoration: InputDecoration(
                          hintText: "Account Name:",
                          hintStyle: TextStyle(color: AppStyles.bgBlack),
                          ),
                        ),
                        TextFormField(
                          controller: accountNumberController,
                          //obscureText: true,
                          decoration:  InputDecoration(
                          hintText: "Account Number:",
                          hintStyle: TextStyle(color: AppStyles.bgBlack),
                           ),
                        ),
                        TextFormField(
                          controller: bankNameController,
                          obscureText: true,
                          decoration:  InputDecoration(
                          hintText: "Bank Name:",
                          hintStyle: TextStyle(color: AppStyles.bgBlack),
                           ),
                        ),
                      ],
                    ),
                  ),  
                  SizedBox(height: 3.0.hp),
                  SizedBox(
                    height: 7.0.hp,
                    width: 40.0.wp,
                    child: CustomButton(
                      text: 'Submit', 
                      width: double.maxFinite,
                      height: 6.0.hp, 
                      fontSize: 20.0.sp, 
                      fontColor: Colors.white, 
                      fontWeight:FontWeight.normal, 
                      borderRadius: 20, 
                      backgroundColor: AppStyles.bgBlue, 
                      onTapHandler: (){},
                    ),
                  ),  
                ],
              ),
          ),
        ),
    );
  }
}

class CustomProfileCard extends StatefulWidget {
  const CustomProfileCard({super.key});

  @override
  State<CustomProfileCard> createState() =>_CustomProfileCardState();
}
class _CustomProfileCardState extends State<CustomProfileCard> {
  bool showPassword=true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
          width: 80.0.wp,
          height: 40.0.hp,
          padding: EdgeInsets.all(10.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: true,
            shadowColor: AppStyles.bgBlue,
            elevation: 10,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  CustomTextWidget(
                    text: 'Enter password to authorize changes'
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormPasswordField(
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ), 
                      showPassword: showPassword, 
                      hintText: 'Password',
                      background: AppStyles.bgGray4,
                    ),
                  ),
                  SizedBox(height: 2.0.hp),

                  Padding(
                    padding: EdgeInsets.only(left:10.0.hp,right: 10.0.hp),
                    child: CustomButton(
                      text: 'Authorize', 
                      width: double.maxFinite,
                      height: 6.0.hp, 
                      fontSize: 15.0.sp, 
                      fontColor: Colors.white, 
                      fontWeight:FontWeight.normal, 
                      borderRadius: 20, 
                      backgroundColor: AppStyles.bgBlue, 
                      onTapHandler: (){},
                    ),
                  ),  
                ],
              ),
          ),
        ),
    );
  }
}


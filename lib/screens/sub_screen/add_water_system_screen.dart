import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:geo_tek/utils/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:geo_tek/widgets/text/cutom_formtext_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Prefer the shared GetStorage instance from auth_controller
// GetStorage getStorage = GetStorage();

class AddWaterSystemScreen extends StatefulWidget {
  const AddWaterSystemScreen({super.key});

  @override
  State<AddWaterSystemScreen> createState() => _AddWaterSystemScreenState();
}

class _AddWaterSystemScreenState extends State<AddWaterSystemScreen> {
  Dio dio = Dio();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController locationController = TextEditingController();

  late PlatformFile image;
  bool imageUploaded = false;
  String selectedValue = 'Option 1';
  String waterQualityValue = 'Poor';
  String pumpFunctionalityValue = 'Faulty';

  RxBool isAddWaterSystemProcessing = false.obs;

  final List<String> dropdownOptions = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
  ];

  final List<String> waterQualityOptions = [
    "Excellent",
    "Good",
    "Fair",
    "Poor",
    "Hazardous"
  ];

  final List<String> pumpFunctionalityOptions = [
    "Optimal",
    "Operational",
    "Underperforming",
    "Faulty",
    "Non-Operational"
  ];

  void submitHandler() async {
    try {
      isAddWaterSystemProcessing.value = true;
      if (locationController.text.isEmpty) {
        isAddWaterSystemProcessing.value = false;
        Get.snackbar(
          "Error",
          "Location is required",
          colorText: AppStyles.bgWhite,
          duration: const Duration(milliseconds: 3500),
          backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        );
        return;
      }

      final user = getStorage.read(sessionKey);

      if (user == null) {
        isAddWaterSystemProcessing.value = false;

        Get.snackbar("Error", "user not found. Please Log in again.",
            colorText: AppStyles.bgWhite,
            duration: const Duration(milliseconds: 3500),
            backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5));
        return;
      }

      // Primary persistence: localStorage (GetStorage) — aligns with local auth
      // and works offline. Firebase Firestore is a better fit only if staff need
      // a shared cloud inbox; left commented below for easy restore.
      final report = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': user['email']?.toString() ?? 'unknown@gmail.com',
        'name': user['name']?.toString() ?? 'unknown',
        'location': locationController.text.trim(),
        'waterQuality': waterQualityValue,
        'pumpFunctionality': pumpFunctionalityValue,
        'latitude': user['latitude'],
        'longitude': user['longitude'],
        'imagePath': imageUploaded ? image.path : null,
        'createdAt': DateTime.now().toIso8601String(),
      };

      AuuthController.authInstance.saveReport(report);

      // ── FIREBASE Firestore report save (commented out — restore if needed) ──
      // await FirebaseFirestore.instance.collection('reports').add({
      //   ...report,
      //   'createdAt': FieldValue.serverTimestamp(),
      // });

      // Optional remote notification (existing API) — best-effort, does not
      // block local save success if the network call fails.
      try {
        Map data = {
          "lastName": " ",
          "email": report['email'],
          "firstName": report['name'],
          "message":
              "GEOTEK: Add Water System \nLocation: ${report['location']}\nWater Quality: $waterQualityValue\nPump Functionality: $pumpFunctionalityValue\nLatitude: ${report['latitude']}\nLongitude: ${report['longitude']}",
        };
        await dio.post(
          "https://livestocx.xyz/api/v1/notifications/contact-us",
          data: data,
        );
      } catch (apiError) {
        log('[REPORT-API-BEST-EFFORT-FAILED] :: $apiError');
      }

      isAddWaterSystemProcessing.value = false;

      Get.snackbar(
        "Message",
        "Successful, we will contact you within 3-5 business working days to install our hardware.",
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgPrimary.withOpacity(0.5),
        duration: const Duration(milliseconds: 6500),
      );

      setState(() {
        imageUploaded = false;
        locationController.clear();
      });
    } catch (error) {
      isAddWaterSystemProcessing.value = false;

      log('[ADD-WATER-SYSTEM-ERROR] :: $error');

      Get.snackbar(
        "Message",
        "An error occurred please try again!.",
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgPrimary.withOpacity(0.5),
        duration: const Duration(milliseconds: 6500),
      );

      if (error is DioError) {
        log('[ADD-WATER-SYSTEM-ERROR] :: $error');
        log('[ADD-WATER-SYSTEM-ERROR] :: ${error.error}');
        log('[ADD-WATER-SYSTEM-ERROR] :: ${error.response}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              top: 4.0,
              left: 4.0.wp,
            ),
            child: PageHeader(scaffoldKey: scaffoldKey),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomTextWidget(
                  text: 'Add Water Infrastructure',
                  weight: FontWeight.bold,
                  color: AppStyles.bgPrimary,
                  size: constructFontSize(context, 16),
                ),
              ),
              SizedBox(height: 8.0.hp),
              CustomFormTextField(
                hintText: 'Location',
                controller: locationController,
                maxLines: 1,
                height: 60,
                borderRadius: 5,
                paddingTop: 15,
                textColor: AppStyles.bgBlack,
                hintColor: AppStyles.bgGray,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: waterQualityValue,
                decoration: InputDecoration(
                  labelText: 'Water Quality',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppStyles.bgGray),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: waterQualityOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    waterQualityValue = newValue!;
                  });
                },
                hint: const Text("Water quality"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: pumpFunctionalityValue,
                decoration: InputDecoration(
                  labelText: 'Pump Functionality',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppStyles.bgGray),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: pumpFunctionalityOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pumpFunctionalityValue = newValue!;
                  });
                },
                hint: const Text("Pump functionality"),
              ),
              SizedBox(height: 2.0.hp),
              Center(
                child: CustomButton(
                  text: imageUploaded ? 'Update Image' : 'Choose Image',
                  width: 150,
                  height: 35,
                  onTapHandler: () async {
                    // Upload File Handler
                    // PlatformFile? platformFile = await getImageFromGallery();
                    PlatformFile? platformFile = await pickImage(context);

                    setState(() {
                      if (platformFile != null) {
                        imageUploaded = true;
                        image = platformFile;
                      }
                    });
                  },
                  fontSize: 14,
                  fontColor: imageUploaded == false
                      ? AppStyles.bgPrimary
                      : AppStyles.bgWhite,
                  fontWeight: FontWeight.w600,
                  borderRadius: 5,
                  borderColor: imageUploaded == false
                      ? AppStyles.bgPrimary
                      : AppStyles.bgWhite,
                  backgroundColor: imageUploaded == false
                      ? AppStyles.bgWhite
                      : AppStyles.bgPrimary,
                ),
              ),
              SizedBox(height: 1.0.hp),
              Visibility(
                visible: imageUploaded,
                child: imageUploaded
                    ? Center(
                        child: Image.file(
                          File(image.path!),
                          width: 200,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 25),
              Obx(() {
                return isAddWaterSystemProcessing.isTrue
                    ? Container(
                        height: 60,
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
                        height: 60,
                        onTapHandler: submitHandler,
                        fontSize: 12.0.sp,
                        borderRadius: 25,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: AppStyles.bgPrimary,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

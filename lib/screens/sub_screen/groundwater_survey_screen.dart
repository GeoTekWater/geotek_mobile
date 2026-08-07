import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/models/groundwater_survey_model.dart';
import 'package:geo_tek/services/groundwater_survey_service.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroundwaterSurveyScreen extends StatefulWidget {
  const GroundwaterSurveyScreen({super.key});

  @override
  State<GroundwaterSurveyScreen> createState() =>
      _GroundwaterSurveyScreenState();
}

class _GroundwaterSurveyScreenState extends State<GroundwaterSurveyScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GroundwaterSurveyService _surveyService = GroundwaterSurveyService();

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController clientController = TextEditingController();
  final TextEditingController reportedByController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  GroundwaterSurveyModel? surveyModel;
  final RxBool isSubmitting = false.obs;

  @override
  void initState() {
    super.initState();
    _prefillFromSession();
  }

  void _prefillFromSession() {
    final session = getStorage.read(sessionKey);
    if (session == null) return;

    final name = session['name']?.toString();
    if (name != null && name.isNotEmpty) {
      reportedByController.text = name;
    }

    final lat = session['latitude'];
    final lng = session['longitude'];
    if (lat != null) latitudeController.text = lat.toString();
    if (lng != null) longitudeController.text = lng.toString();
  }

  @override
  void dispose() {
    locationNameController.dispose();
    clientController.dispose();
    reportedByController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  Future<void> _pickSurveyFile() async {
    final file = await _surveyService.pickSurveyFile();
    if (file == null) return;

    setState(() {
      surveyModel = _surveyService.modelFromPickedFile(file);
    });
  }

  void _clearFile() {
    setState(() => surveyModel = null);
  }

  double? _parseCoordinate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return double.tryParse(trimmed);
  }

  GroundwaterSurveyModel _buildSurveyPayload() {
    final base = surveyModel ?? GroundwaterSurveyModel();

    return base.copyWith(
      locationName: locationNameController.text.trim(),
      client: clientController.text.trim(),
      reportedBy: reportedByController.text.trim(),
      latitude: _parseCoordinate(latitudeController.text),
      longitude: _parseCoordinate(longitudeController.text),
    );
  }

  Future<void> _submitSurvey() async {
    final survey = _buildSurveyPayload();

    if (!survey.hasFile) {
      Get.snackbar(
        'Required',
        'Please upload a survey file to continue.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final result = await _surveyService.submitSurvey(survey);

      isSubmitting.value = false;

      if (result.success) {
        Get.snackbar(
          'Success',
          result.message,
          colorText: AppStyles.bgWhite,
          backgroundColor: AppStyles.bgPrimary.withOpacity(0.85),
          duration: const Duration(seconds: 4),
        );

        setState(() {
          surveyModel = null;
          locationNameController.clear();
          clientController.clear();
          reportedByController.clear();
          latitudeController.clear();
          longitudeController.clear();
        });
        _prefillFromSession();
      } else {
        log('[SURVEY-SUBMIT-FAILED] :: ${result.statusCode} ${result.message}');
        Get.snackbar(
          'Error',
          result.message,
          colorText: AppStyles.bgWhite,
          backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
          duration: const Duration(seconds: 5),
        );
      }
    } catch (error) {
      isSubmitting.value = false;
      log('[SURVEY-SUBMIT-ERROR] :: $error');

      Get.snackbar(
        'Error',
        'An error occurred while submitting the survey.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF5F6FA),
      drawer: const SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, left: 4.0.wp),
            child: PageHeader(scaffoldKey: scaffoldKey),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 1.0.hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Groundwater Survey',
                weight: FontWeight.bold,
                color: AppStyles.bgPrimary,
                size: constructFontSize(context, 22),
              ),
              const SizedBox(height: 6),
              CustomTextWidget(
                text:
                    'Upload field survey data and optionally add location details.',
                color: AppStyles.bgGray,
                size: constructFontSize(context, 13),
              ),
              SizedBox(height: 3.0.hp),
              _buildUploadCard(context),
              SizedBox(height: 2.5.hp),
              
              const SizedBox(height: 12),
              _buildLabeledField(
                context,
                label: 'Location name',
                hint: 'e.g. Jos North borehole site',
                controller: locationNameController,
              ),
              const SizedBox(height: 14),
              _buildLabeledField(
                context,
                label: 'Client',
                hint: 'Client or organization name',
                controller: clientController,
              ),
              const SizedBox(height: 14),
              _buildLabeledField(
                context,
                label: 'Reported by',
                hint: 'Your name',
                controller: reportedByController,
              ),
              const SizedBox(height: 14),
              _buildLabeledField(
                context,
                label: 'Latitude',
                hint: 'e.g. 9.8965',
                controller: latitudeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
              ),
              const SizedBox(height: 14),
              _buildLabeledField(
                context,
                label: 'Longitude',
                hint: 'e.g. 8.8583',
                controller: longitudeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
              ),
              SizedBox(height: 4.0.hp),
              Obx(() {
                if (isSubmitting.value) {
                  return Container(
                    height: 56,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppStyles.bgPrimary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: LoadingAnimationWidget.hexagonDots(
                        color: AppStyles.bgWhite,
                        size: 28,
                      ),
                    ),
                  );
                }

                return CustomButton(
                  text: 'Submit Survey',
                  width: double.maxFinite,
                  height: 56,
                  onTapHandler: _submitSurvey,
                  fontSize: constructFontSize(context, 16),
                  borderRadius: 14,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w600,
                  backgroundColor: AppStyles.bgPrimary,
                );
              }),
              SizedBox(height: 3.0.hp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(BuildContext context) {
    final hasFile = surveyModel?.hasFile == true;

    return GestureDetector(
      onTap: _pickSurveyFile,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasFile
                ? AppStyles.bgPrimary.withOpacity(0.55)
                : AppStyles.bgPrimary.withOpacity(0.2),
            width: hasFile ? 1.5 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppStyles.bgPrimary.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: hasFile ? _buildSelectedFileView() : _buildEmptyUploadView(),
      ),
    );
  }

  Widget _buildEmptyUploadView() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppStyles.bgPrimaryLight,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            size: 32,
            color: AppStyles.bgPrimary,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextWidget(
          text: 'Upload survey file',
          weight: FontWeight.w600,
          color: AppStyles.bgPrimary,
          size: constructFontSize(context, 16),
        ),
        const SizedBox(height: 6),
        CustomTextWidget(
          text: 'CSV, DOC, DOCX, or PDF  ·  Required',
          color: AppStyles.bgGray,
          size: constructFontSize(context, 12),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppStyles.bgPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomTextWidget(
            text: 'Choose file',
            color: AppStyles.bgWhite,
            size: constructFontSize(context, 12),
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedFileView() {
    final survey = surveyModel!;
    final ext = (survey.file?.split('.').last ?? '').toUpperCase();

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppStyles.bgPrimaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: CustomTextWidget(
              text: ext.isEmpty ? 'FILE' : ext,
              color: AppStyles.bgPrimary,
              weight: FontWeight.bold,
              size: constructFontSize(context, 11),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: survey.file ?? 'Selected file',
                color: AppStyles.bgBlack,
                weight: FontWeight.w600,
                size: constructFontSize(context, 13),
              ),
              const SizedBox(height: 4),
              CustomTextWidget(
                text: _surveyService.formatFileSize(survey.fileSize ?? 0),
                color: AppStyles.bgGray,
                size: constructFontSize(context, 11),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _clearFile,
          icon: Icon(Icons.close_rounded, color: AppStyles.bgGray),
          tooltip: 'Remove file',
        ),
      ],
    );
  }

  Widget _buildLabeledField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label,
          color: AppStyles.bgBlack,
          weight: FontWeight.w500,
          size: constructFontSize(context, 13),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppStyles.bgGray.withOpacity(0.35)),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: AppStyles.bgBlack,
              fontSize: constructFontSize(context, 14),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppStyles.bgGray4,
                fontSize: constructFontSize(context, 13),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

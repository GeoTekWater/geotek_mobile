import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/models/survey_agent_report_model.dart';
import 'package:geo_tek/services/survey_report_pdf_service.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/widgets/navigation/pageheader.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroundwaterSurveyResultScreen extends StatefulWidget {
  final SurveyProcessingResult processingResult;

  const GroundwaterSurveyResultScreen({
    super.key,
    required this.processingResult,
  });

  @override
  State<GroundwaterSurveyResultScreen> createState() =>
      _GroundwaterSurveyResultScreenState();
}

class _GroundwaterSurveyResultScreenState
    extends State<GroundwaterSurveyResultScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SurveyReportPdfService _pdfService = SurveyReportPdfService();

  final RxBool isGeneratingPdf = false.obs;
  String? savedPdfPath;

  SurveyAgentReport? get agentReport => widget.processingResult.agentReport;

  Future<void> _downloadPdf() async {
    final report = agentReport;
    if (report == null) {
      Get.snackbar(
        'Unavailable',
        'No agent report was returned by the server.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
      return;
    }

    try {
      isGeneratingPdf.value = true;

      final File pdfFile = await _pdfService.generateAndSaveAgentReportPdf(
        agentReport: report,
        analysisId: widget.processingResult.analysisId,
        report: widget.processingResult.report,
        warnings: widget.processingResult.warnings,
      );

      savedPdfPath = pdfFile.path;
      isGeneratingPdf.value = false;

      Get.snackbar(
        'PDF ready',
        'Saved to: ${pdfFile.path}',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgPrimary.withOpacity(0.85),
        duration: const Duration(seconds: 4),
      );

      await _pdfService.openPdf(pdfFile);
    } catch (error) {
      isGeneratingPdf.value = false;
      log('[SURVEY-PDF-ERROR] :: $error');
      Get.snackbar(
        'Error',
        'Could not generate or open the PDF.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = agentReport;

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
          padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 1.5.hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Survey Result',
                weight: FontWeight.bold,
                color: AppStyles.bgPrimary,
                size: constructFontSize(context, 22),
              ),
              const SizedBox(height: 6),
              CustomTextWidget(
                text: report?.title ?? 'Agent report ready',
                color: AppStyles.bgGray,
                size: constructFontSize(context, 13),
              ),
              SizedBox(height: 2.0.hp),
              _infoCard(
                children: [
                  _metaRow('Analysis ID', widget.processingResult.analysisId),
                  if (widget.processingResult.warnings.isNotEmpty)
                    _metaRow(
                      'Warnings',
                      widget.processingResult.warnings.join(', '),
                    ),
                ],
              ),
              SizedBox(height: 2.0.hp),
              if (report != null) ...[
                CustomTextWidget(
                  text: 'Executive summary',
                  weight: FontWeight.w600,
                  color: AppStyles.bgPrimary,
                  size: constructFontSize(context, 15),
                ),
                const SizedBox(height: 8),
                _infoCard(
                  children: [
                    CustomTextWidget(
                      text: report.executiveSummary.isEmpty
                          ? 'No executive summary provided.'
                          : report.executiveSummary,
                      color: AppStyles.bgBlack,
                      size: constructFontSize(context, 13),
                    ),
                  ],
                ),
                SizedBox(height: 2.0.hp),
                if (report.cautions.isNotEmpty) ...[
                  CustomTextWidget(
                    text: 'Cautions',
                    weight: FontWeight.w600,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 15),
                  ),
                  const SizedBox(height: 8),
                  _infoCard(
                    children: report.cautions
                        .map(
                          (caution) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: CustomTextWidget(
                              text: '• $caution',
                              color: AppStyles.bgBlack,
                              size: constructFontSize(context, 13),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 2.0.hp),
                ],
                if (report.artifactCaptions.isNotEmpty) ...[
                  CustomTextWidget(
                    text: 'Artifact captions',
                    weight: FontWeight.w600,
                    color: AppStyles.bgPrimary,
                    size: constructFontSize(context, 15),
                  ),
                  const SizedBox(height: 8),
                  _infoCard(
                    children: report.artifactCaptions
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: item.artifactKey,
                                  weight: FontWeight.w600,
                                  color: AppStyles.bgPrimary,
                                  size: constructFontSize(context, 13),
                                ),
                                const SizedBox(height: 2),
                                CustomTextWidget(
                                  text: item.caption,
                                  color: AppStyles.bgBlack,
                                  size: constructFontSize(context, 12),
                                ),
                                const SizedBox(height: 2),
                                CustomTextWidget(
                                  text: 'Relevance: ${item.relevance}',
                                  color: AppStyles.bgGray,
                                  size: constructFontSize(context, 12),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 2.5.hp),
                ],
              ] else
                _infoCard(
                  children: [
                    CustomTextWidget(
                      text:
                          'The server did not return an agentReport object to render.',
                      color: AppStyles.bgBlack,
                      size: constructFontSize(context, 13),
                    ),
                  ],
                ),
              if (savedPdfPath != null) ...[
                CustomTextWidget(
                  text: 'Saved file',
                  weight: FontWeight.w600,
                  color: AppStyles.bgPrimary,
                  size: constructFontSize(context, 13),
                ),
                const SizedBox(height: 6),
                CustomTextWidget(
                  text: savedPdfPath!,
                  color: AppStyles.bgGray,
                  size: constructFontSize(context, 11),
                ),
                SizedBox(height: 2.0.hp),
              ],
              Obx(() {
                if (isGeneratingPdf.value) {
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
                  text: 'Download PDF',
                  width: double.maxFinite,
                  height: 56,
                  onTapHandler: _downloadPdf,
                  fontSize: constructFontSize(context, 16),
                  borderRadius: 14,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w600,
                  backgroundColor: AppStyles.bgPrimary,
                );
              }),
              SizedBox(height: 1.5.hp),
              CustomButton(
                text: 'Back to survey form',
                width: double.maxFinite,
                height: 52,
                onTapHandler: () => Get.back(),
                fontSize: constructFontSize(context, 14),
                borderRadius: 14,
                fontColor: AppStyles.bgPrimary,
                fontWeight: FontWeight.w600,
                backgroundColor: AppStyles.bgPrimaryLight,
              ),
              SizedBox(height: 3.0.hp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppStyles.bgGray.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _metaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: label,
            weight: FontWeight.w600,
            color: AppStyles.bgPrimary,
            size: constructFontSize(context, 12),
          ),
          const SizedBox(height: 2),
          CustomTextWidget(
            text: value.isEmpty ? '-' : value,
            color: AppStyles.bgBlack,
            size: constructFontSize(context, 13),
          ),
        ],
      ),
    );
  }
}

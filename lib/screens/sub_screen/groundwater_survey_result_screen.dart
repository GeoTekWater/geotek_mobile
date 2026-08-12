import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/models/survey_agent_report_model.dart';
import 'package:geo_tek/services/survey_report_pdf_service.dart';
import 'package:get/get.dart';

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
  final SurveyReportPdfService _pdfService = SurveyReportPdfService();

  bool _isPreparingPreview = false;
  bool _isSavingPdf = false;
  bool _isPdfReady = false;
  File? _previewPdfFile;

  SurveyAgentReport? get agentReport => widget.processingResult.agentReport;

  @override
  void initState() {
    super.initState();
    _preparePreviewPdf();
  }

  Future<void> _preparePreviewPdf() async {
    final report = agentReport;
    if (report == null) {
      return;
    }

    setState(() {
      _isPreparingPreview = true;
      _isPdfReady = false;
    });

    try {
      final previewFile = await _pdfService.ensurePreviewPdf(
        agentReport: report,
        analysisId: widget.processingResult.analysisId,
        report: widget.processingResult.report,
        warnings: widget.processingResult.warnings,
      );

      if (!mounted) return;
      setState(() {
        _previewPdfFile = previewFile;
      });
    } catch (error) {
      log('[SURVEY-PDF-PREVIEW-ERROR] :: $error');
      if (!mounted) return;
      Get.snackbar(
        'Preview unavailable',
        'Could not generate the PDF preview.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isPreparingPreview = false;
      });
    }
  }

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
      setState(() {
        _isSavingPdf = true;
      });

      final File pdfFile = await _pdfService.saveAgentReportPdf(
        agentReport: report,
        analysisId: widget.processingResult.analysisId,
        report: widget.processingResult.report,
        warnings: widget.processingResult.warnings,
      );

      if (!mounted) return;
      Get.snackbar(
        'PDF ready',
        'Saved to: ${pdfFile.path}',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgPrimary.withOpacity(0.85),
        duration: const Duration(seconds: 4),
      );
    } catch (error) {
      log('[SURVEY-PDF-ERROR] :: $error');
      if (!mounted) return;
      Get.snackbar(
        'Error',
        'Could not generate or open the PDF.',
        colorText: AppStyles.bgWhite,
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.7),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isSavingPdf = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = agentReport;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          report == null || _isSavingPdf ? null : _downloadPdf,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.bgPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isSavingPdf
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Download PDF'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: report == null
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No agent report available.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : _buildPreviewContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewContent() {
    if (_isPreparingPreview) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final previewFile = _previewPdfFile;
    if (previewFile == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'PDF preview unavailable.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: PDFView(
            key: ValueKey(previewFile.path),
            filePath: previewFile.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            fitPolicy: FitPolicy.BOTH,
            onRender: (_) {
              if (!mounted) return;
              setState(() {
                _isPdfReady = true;
              });
            },
            onError: (error) {
              log('[SURVEY-PDF-VIEW-ERROR] :: $error');
            },
            onPageError: (page, error) {
              log('[SURVEY-PDF-VIEW-PAGE-ERROR] :: Page $page :: $error');
            },
          ),
        ),
        if (!_isPdfReady)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

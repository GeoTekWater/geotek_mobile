import 'package:geo_tek/models/survey_agent_report_model.dart';

/// Result of a groundwater survey submission attempt.
class GroundwaterSurveySubmitResult {
  final bool success;
  final String message;
  final int? statusCode;
  final SurveyProcessingResult? processingResult;

  const GroundwaterSurveySubmitResult({
    required this.success,
    required this.message,
    this.statusCode,
    this.processingResult,
  });

  factory GroundwaterSurveySubmitResult.success({
    int? statusCode,
    SurveyProcessingResult? processingResult,
  }) {
    return GroundwaterSurveySubmitResult(
      success: true,
      message: 'Survey data submitted successfully.',
      statusCode: statusCode,
      processingResult: processingResult,
    );
  }

  factory GroundwaterSurveySubmitResult.failure({
    required String message,
    int? statusCode,
  }) {
    return GroundwaterSurveySubmitResult(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}

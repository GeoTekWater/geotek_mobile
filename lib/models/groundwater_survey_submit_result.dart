/// Result of a groundwater survey submission attempt.
class GroundwaterSurveySubmitResult {
  final bool success;
  final String message;
  final int? statusCode;

  const GroundwaterSurveySubmitResult({
    required this.success,
    required this.message,
    this.statusCode,
  });

  factory GroundwaterSurveySubmitResult.success({int? statusCode}) {
    return GroundwaterSurveySubmitResult(
      success: true,
      message: 'Survey data submitted successfully.',
      statusCode: statusCode,
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

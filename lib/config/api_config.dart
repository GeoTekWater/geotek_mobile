
class ApiConfig {
  ApiConfig._();

  /// Monitoring service (Swagger server URL).
  static const String monitoringBaseUrl = String.fromEnvironment(
    'MONITORING_API_BASE_URL',
    defaultValue: 'https://infra-geotek.livestocx.xyz',
  );

  /// Legacy notification/contact service.
  static const String notificationsBaseUrl = String.fromEnvironment(
    'NOTIFICATIONS_API_BASE_URL',
    defaultValue: 'https://livestocx.xyz',
  );

  static const String notificationsApiPrefix = String.fromEnvironment(
    'NOTIFICATIONS_API_PREFIX',
    defaultValue: '/api',
  );

  static String get processSurveyData =>
      '$monitoringBaseUrl/v1/monitoring/water-point/process-survey-data';

  static String get contactUs =>
      '$notificationsBaseUrl$notificationsApiPrefix/v1/notifications/contact-us';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 120);
}

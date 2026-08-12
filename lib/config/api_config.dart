
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._();

  /// Monitoring service (Swagger server URL).
  static String get monitoringBaseUrl => dotenv.env['MONITORING_API_BASE_URL'] ??
      'https://infra-geotek.livestocx.xyz';

  /// Legacy notification/contact service.
  static String get notificationsBaseUrl =>
      dotenv.env['NOTIFICATIONS_API_BASE_URL'] ?? 'https://livestocx.xyz';

  static String get notificationsApiPrefix =>
      dotenv.env['NOTIFICATIONS_API_PREFIX'] ?? '/api';

  static String get processSurveyData =>
      '$monitoringBaseUrl/v1/monitoring/water-point/process-survey-data';

  static String get contactUs =>
      '$notificationsBaseUrl$notificationsApiPrefix/v1/notifications/contact-us';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 60);
}

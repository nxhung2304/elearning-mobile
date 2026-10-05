import 'package:elearning_mobile/app/logger/app_logger.dart';

class ApiConfig {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );

  static void validate() {
    final uri = Uri.tryParse(baseUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      throw StateError('Invalid API_BASE_URL: "$baseUrl"');
    }
    AppLogger.info('API_BASE_URL = $baseUrl');
  }
}

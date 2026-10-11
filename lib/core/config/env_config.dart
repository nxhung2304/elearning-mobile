import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';
  static String get appName => dotenv.env['APP_NAME'] ?? 'Elearning';
}

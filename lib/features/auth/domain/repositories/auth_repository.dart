import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';

abstract class AuthRepository {
  Future<AuthStatus> getAuthStatus();
}

import 'package:elearning_mobile/features/auth/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_session_model.g.dart';

@JsonSerializable(createJsonSchema: true, fieldRename: FieldRename.snake)
class AuthSessionModel {
  String accessToken;
  String refreshToken;
  int expiresIn;
  UserModel user;

  AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);

  static const jsonSchema = _$AuthSessionModelJsonSchema;
}

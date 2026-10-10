import 'package:elearning_mobile/features/auth/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_session_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class AuthSessionModel {
  String token;
  UserModel user;

  AuthSessionModel({required this.token, required this.user});

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);

  static const jsonSchema = _$AuthSessionModelJsonSchema;
}

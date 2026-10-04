import 'package:elearning_mobile/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserModelStatus { active, inactive, suspended, deleted }

@JsonSerializable(createJsonSchema: true)
class UserModel {
  int id;
  String email;
  String? name;
  UserModelStatus status;

  UserModel({
    required this.id,
    required this.email,
    required this.status,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static const jsonSchema = _$UserModelJsonSchema;

  User toEntity() {
    return User(id: id, email: email, name: name, status: status.name);
  }
}

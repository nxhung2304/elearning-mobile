import 'package:json_annotation/json_annotation.dart';

part 'reset_password_model.g.dart';

@JsonSerializable(createJsonSchema: true, fieldRename: FieldRename.snake)
class ResetPasswordModel {
  String resetPasswordToken;

  ResetPasswordModel({required this.resetPasswordToken});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);

  static const jsonSchema = _$ResetPasswordModelJsonSchema;
}

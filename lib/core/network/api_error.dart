import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable(createJsonSchema: true, fieldRename: FieldRename.snake)
class ApiError {
  final String code;
  final String? message;
  final String? extra;

  ApiError({this.extra, required this.code, this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

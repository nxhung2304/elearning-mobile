import 'package:json_annotation/json_annotation.dart';

part 'course_category.g.dart';

@JsonSerializable(createJsonSchema: true, fieldRename: FieldRename.snake)
class CourseCategory {
  final int id;
  final String name;
  final int? parentId;

  CourseCategory({required this.id, required this.name, this.parentId});

  factory CourseCategory.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryToJson(this);

  static const jsonSchema = _$CourseCategoryJsonSchema;
}

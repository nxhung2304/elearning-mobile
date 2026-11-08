import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/home/data/models/course_category.dart';

abstract class CourseRepository {
  Future<Result<List<CourseCategory>>> getCategories();
}

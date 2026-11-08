import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/home/data/models/course_category.dart';
import 'package:elearning_mobile/features/home/data/repositories/course_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<List<CourseCategory>> build() async {
    final categoriesResult = await ref
        .watch(courseRepositoryProvider)
        .getCategories();

    switch (categoriesResult) {
      case Ok(value: final categories):
        return categories;
      case Error(error: final e):
        throw e;
    }
  }
}

import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/home/data/data_sources/course_remote_data_source.dart';
import 'package:elearning_mobile/features/home/data/models/course_category.dart';
import 'package:elearning_mobile/features/home/domain/repositories/course_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_repository_impl.g.dart';

@riverpod
CourseRepository courseRepository(Ref ref) {
  return CourseRepositoryImpl(ref.watch(courseRemoteDataSourceProvider));
}

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;

  CourseRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<CourseCategory>>> getCategories() async {
    final result = await _remoteDataSource.getCategories();
    switch (result) {
      case Ok(value: final categories):
        return Result.ok(categories);
      case Error(error: final e):
        return Result.error(e);
    }
  }
}

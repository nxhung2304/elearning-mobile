import 'dart:io';

import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/network/api_client.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/home/data/models/course_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_remote_data_source.g.dart';

@riverpod
CourseRemoteDataSource courseRemoteDataSource(Ref ref) {
  return CourseRemoteDataSource(ref.watch(apiClientProvider));
}

class CourseRemoteDataSource {
  final String fetchCourseCategoriesEndpoint = '/course_categories';

  final ApiClient _apiClient;

  CourseRemoteDataSource(this._apiClient);

  Future<Result<List<CourseCategory>>> getCategories() async {
    try {
      final response = await _apiClient.get(fetchCourseCategoriesEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final categories = data
            .map((categoryJson) => CourseCategory.fromJson(categoryJson))
            .toList();

        return Result.ok(categories);
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on AppException catch (exception) {
      return Result.error(exception);
    }
  }
}

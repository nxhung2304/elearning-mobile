// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(courseRemoteDataSource)
final courseRemoteDataSourceProvider = CourseRemoteDataSourceProvider._();

final class CourseRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CourseRemoteDataSource,
          CourseRemoteDataSource,
          CourseRemoteDataSource
        >
    with $Provider<CourseRemoteDataSource> {
  CourseRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CourseRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CourseRemoteDataSource create(Ref ref) {
    return courseRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseRemoteDataSource>(value),
    );
  }
}

String _$courseRemoteDataSourceHash() =>
    r'0d1e9081ca52c3ceebe8ca0cdbf20a46b2942781';

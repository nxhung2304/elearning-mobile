// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_auth_status_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkAuthStatusUseCase)
final checkAuthStatusUseCaseProvider = CheckAuthStatusUseCaseProvider._();

final class CheckAuthStatusUseCaseProvider
    extends
        $FunctionalProvider<
          CheckAuthStatusUseCase,
          CheckAuthStatusUseCase,
          CheckAuthStatusUseCase
        >
    with $Provider<CheckAuthStatusUseCase> {
  CheckAuthStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkAuthStatusUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkAuthStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<CheckAuthStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckAuthStatusUseCase create(Ref ref) {
    return checkAuthStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckAuthStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckAuthStatusUseCase>(value),
    );
  }
}

String _$checkAuthStatusUseCaseHash() =>
    r'40660ec22d1ba0368de52a44ffb0d39728d07334';

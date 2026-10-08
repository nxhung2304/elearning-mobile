// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_shared_preference.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appSharedPreference)
final appSharedPreferenceProvider = AppSharedPreferenceProvider._();

final class AppSharedPreferenceProvider
    extends
        $FunctionalProvider<
          AppSharedPreference,
          AppSharedPreference,
          AppSharedPreference
        >
    with $Provider<AppSharedPreference> {
  AppSharedPreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSharedPreferenceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSharedPreferenceHash();

  @$internal
  @override
  $ProviderElement<AppSharedPreference> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppSharedPreference create(Ref ref) {
    return appSharedPreference(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSharedPreference value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSharedPreference>(value),
    );
  }
}

String _$appSharedPreferenceHash() =>
    r'18a7784e6a0f768b8baa4d0a37979ebcbdc9cf3d';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignInController)
final signInControllerProvider = SignInControllerProvider._();

final class SignInControllerProvider
    extends $NotifierProvider<SignInController, AsyncValue<AuthSessionModel?>> {
  SignInControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInControllerHash();

  @$internal
  @override
  SignInController create() => SignInController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AuthSessionModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AuthSessionModel?>>(
        value,
      ),
    );
  }
}

String _$signInControllerHash() => r'121d88fe560753326b5e8ae2ffc85b3bd0f94657';

abstract class _$SignInController
    extends $Notifier<AsyncValue<AuthSessionModel?>> {
  AsyncValue<AuthSessionModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<AuthSessionModel?>,
              AsyncValue<AuthSessionModel?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AuthSessionModel?>,
                AsyncValue<AuthSessionModel?>
              >,
              AsyncValue<AuthSessionModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

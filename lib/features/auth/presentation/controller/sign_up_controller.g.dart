// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignUpController)
final signUpControllerProvider = SignUpControllerProvider._();

final class SignUpControllerProvider
    extends $NotifierProvider<SignUpController, AsyncValue<AuthSession?>> {
  SignUpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpControllerHash();

  @$internal
  @override
  SignUpController create() => SignUpController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AuthSession?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AuthSession?>>(value),
    );
  }
}

String _$signUpControllerHash() => r'cc988d52f272015792efa691796cbd5842443cbe';

abstract class _$SignUpController extends $Notifier<AsyncValue<AuthSession?>> {
  AsyncValue<AuthSession?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AuthSession?>, AsyncValue<AuthSession?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthSession?>, AsyncValue<AuthSession?>>,
              AsyncValue<AuthSession?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

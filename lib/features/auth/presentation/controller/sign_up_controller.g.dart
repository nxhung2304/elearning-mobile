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
    extends $NotifierProvider<SignUpController, AsyncValue<AuthSessionModel?>> {
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
  Override overrideWithValue(AsyncValue<AuthSessionModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AuthSessionModel?>>(
        value,
      ),
    );
  }
}

String _$signUpControllerHash() => r'a4790f80fe6e581c28ab6e72a17d28cbcfedf285';

abstract class _$SignUpController
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

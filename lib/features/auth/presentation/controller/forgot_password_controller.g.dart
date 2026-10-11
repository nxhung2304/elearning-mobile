// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ForgotPasswordController)
final forgotPasswordControllerProvider = ForgotPasswordControllerProvider._();

final class ForgotPasswordControllerProvider
    extends
        $NotifierProvider<
          ForgotPasswordController,
          AsyncValue<AuthSessionModel?>
        > {
  ForgotPasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordControllerHash();

  @$internal
  @override
  ForgotPasswordController create() => ForgotPasswordController();

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

String _$forgotPasswordControllerHash() =>
    r'2f482d01b34250428de60ce82f627932a5e14eea';

abstract class _$ForgotPasswordController
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

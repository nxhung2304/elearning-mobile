// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordController)
final resetPasswordControllerProvider = ResetPasswordControllerProvider._();

final class ResetPasswordControllerProvider
    extends
        $NotifierProvider<
          ResetPasswordController,
          AsyncValue<AuthSessionModel?>
        > {
  ResetPasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordControllerHash();

  @$internal
  @override
  ResetPasswordController create() => ResetPasswordController();

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

String _$resetPasswordControllerHash() =>
    r'7eb4c97195da01ed125140809764dcc11f148bdb';

abstract class _$ResetPasswordController
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

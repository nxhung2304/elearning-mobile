// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertify_otp_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VertifyOtpController)
final vertifyOtpControllerProvider = VertifyOtpControllerProvider._();

final class VertifyOtpControllerProvider
    extends
        $NotifierProvider<
          VertifyOtpController,
          AsyncValue<ResetPasswordModel?>
        > {
  VertifyOtpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vertifyOtpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vertifyOtpControllerHash();

  @$internal
  @override
  VertifyOtpController create() => VertifyOtpController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ResetPasswordModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ResetPasswordModel?>>(
        value,
      ),
    );
  }
}

String _$vertifyOtpControllerHash() =>
    r'94d41c2229e3fa39a320a1b71ed0bb510395821b';

abstract class _$VertifyOtpController
    extends $Notifier<AsyncValue<ResetPasswordModel?>> {
  AsyncValue<ResetPasswordModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ResetPasswordModel?>,
              AsyncValue<ResetPasswordModel?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ResetPasswordModel?>,
                AsyncValue<ResetPasswordModel?>
              >,
              AsyncValue<ResetPasswordModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

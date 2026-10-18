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
    extends $NotifierProvider<VertifyOtpController, AsyncValue<void>> {
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
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$vertifyOtpControllerHash() =>
    r'1c404567b58573f04a8a8b1ff5aa6b671d0541d7';

abstract class _$VertifyOtpController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

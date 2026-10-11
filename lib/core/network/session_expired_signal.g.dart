// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_expired_signal.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SessionExpiredSignal)
final sessionExpiredSignalProvider = SessionExpiredSignalProvider._();

final class SessionExpiredSignalProvider
    extends $NotifierProvider<SessionExpiredSignal, int> {
  SessionExpiredSignalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiredSignalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiredSignalHash();

  @$internal
  @override
  SessionExpiredSignal create() => SessionExpiredSignal();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$sessionExpiredSignalHash() =>
    r'a4cde739fafbe021d77171a02b0ae16cc7974a87';

abstract class _$SessionExpiredSignal extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

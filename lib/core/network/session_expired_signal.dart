import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_expired_signal.g.dart';

@riverpod
class SessionExpiredSignal extends _$SessionExpiredSignal {
  @override
  int build() => 0;

  void notify() => state++;
}

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/app/router/go_router_refresh_notifier.dart';
import 'package:elearning_mobile/app/router/routes.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/ui/viewmodel/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final refreshNotifier = GoRouterRefreshNotifier();

  ref.listen(authStateProvider, (_, _) {
    refreshNotifier.refresh();
  });

  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    routes: routes,
    initialLocation: AppPath.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      return _resolveRedirect(
        ref.read(authStateProvider),
        state.matchedLocation,
      );
    },
  );
}

String? _resolveRedirect(AsyncValue<AuthStatus> authState, String location) {
  if (authState.isLoading) {
    return location == AppPath.splash ? null : AppPath.splash;
  }

  if (authState.hasError) {
    return location == AppPath.login ? null : AppPath.login;
  }

  if (authState.value == AuthStatus.authenticated) {
    final isOnAuthGate =
        location == AppPath.login || location == AppPath.splash;
    return isOnAuthGate ? AppPath.home : null;
  }

  return location == AppPath.login ? null : AppPath.login;
}

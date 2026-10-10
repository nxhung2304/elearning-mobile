import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/app/shell/main_shell_screen.dart';
import 'package:elearning_mobile/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:elearning_mobile/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:elearning_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:elearning_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:elearning_mobile/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> routes = [
  GoRoute(
    path: AppPath.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: AppPath.signIn,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: AppPath.signUp,
    builder: (context, state) => const SignUpScreen(),
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        MainShellScreen(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppPath.home,
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppPath.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  ),
];

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:elearning_mobile/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:elearning_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:elearning_mobile/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> routes = [
  GoRoute(
    path: AppPath.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: AppPath.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: AppPath.signUp,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(path: AppPath.home, builder: (context, state) => const HomeScreen()),
];

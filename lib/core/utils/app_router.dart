import 'package:go_router/go_router.dart';
import 'package:saqar/features/on_boarding/presentation/pages/main_on_boarding.dart';
import 'package:saqar/features/splash/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: MainOnBoarding.routeName,
      builder: (context, state) => const MainOnBoarding(),
    ),
  ],
);

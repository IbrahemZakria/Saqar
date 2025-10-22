import 'package:go_router/go_router.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/pages/main_home_page.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/pages/quran_page.dart';
import 'package:saqar/features/on_boarding/presentation/pages/main_on_boarding.dart';
import 'package:saqar/features/splash/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    // GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: MainOnBoarding.routeName,
      builder: (context, state) => const MainOnBoarding(),
    ),
    GoRoute(
      path: MainHomePage.routeName,
      builder: (context, state) => const MainHomePage(),
    ),
    GoRoute(path: "/", builder: (context, state) => const QuranPage()),
  ],
);

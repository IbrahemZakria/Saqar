import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saqar/features/bottom_navigaton/features/ahades/presentation/pages/ahades_page.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/pages/main_home_page.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/pages/quran_page.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/surah_view.dart';
import 'package:saqar/features/on_boarding/presentation/pages/main_on_boarding.dart';
import 'package:saqar/features/splash/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: MainOnBoarding.routeName,
      builder: (context, state) => const MainOnBoarding(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainHomePage(navigationShell: navigationShell),
      branches: [
        // Branch 0 — Quran
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: QuranPage.routeName,
              name: 'quran',
              builder: (context, state) => const QuranPage(),
              routes: [
                GoRoute(
                  path: SurahView.routeName,
                  name: 'surah',
                  builder: (context, state) {
                    final suraEntity = state.extra as SuraEntity;
                    return SurahView(suraEntity: suraEntity);
                  },
                ),
              ],
            ),
          ],
        ),
        // Branch 1 — Ahades
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AhadesPage.routeName,
              name: 'ahades',
              builder: (context, state) => const AhadesPage(),
            ),
          ],
        ),
        // Branch 2 — Tasbeeh
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tasbeeh',
              name: 'tasbeeh',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Tasbeeh Page'))),
            ),
          ],
        ),
        // Branch 3 — Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Settings Page'))),
            ),
          ],
        ),
        // Branch 4 — Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Profile Page'))),
            ),
          ],
        ),
      ],
    ),
  ],
);

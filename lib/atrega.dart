import 'package:atrega/core/utils/app_router.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/repositories/notification_repository_impl.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/repositories/notification_repository_impl.dart'
    as notif_impl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class Atrega extends StatelessWidget {
  const Atrega({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PrayerCubit(NotificationRepositoryImpl()),
            ),
            BlocProvider(
              create: (context) =>
                  NotificationCubit(notif_impl.NotificationRepositoryImpl()),
            ),
          ],
          child: SafeArea(
            top: true,
            left: false,
            right: false,
            bottom: true,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      routerConfig: router,
      locale: Locale("en"),

      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

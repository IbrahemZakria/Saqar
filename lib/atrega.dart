import 'package:atrega/core/helper/cubit/notification/notification_cubit.dart';
import 'package:atrega/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class Atrega extends StatelessWidget {
  const Atrega({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<PrayerCubit>().fetchPrayerTimesAndScheduleNotifications();
    });

    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: MaterialApp.router(
        builder: (BuildContext context, Widget? child) {
          return SafeArea(
            top: true,
            left: false,
            right: false,
            bottom: true,
            child: child ?? const SizedBox.shrink(),
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
      ),
    );
  }
}

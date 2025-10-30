import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/pages/quran_page.dart';
import 'package:saqar/features/on_boarding/presentation/pages/main_on_boarding.dart';

class SplashNavigator {
  static Future<void> startAnimationAndNavigate({
    required BuildContext context,
    required AnimationController controller,
  }) async {
    await controller.forward();
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final isOnBoardingDone = prefs.getBool('isOnBoardingDone') ?? false;

    if (!context.mounted) return; // لازم نستخدم context.mounted هنا

    if (isOnBoardingDone) {
      context.go(QuranPage.routeName); // الصفحة الرئيسية
    } else {
      await prefs.setBool('isOnBoardingDone', true);

      context.go(MainOnBoarding.routeName); // صفحة OnBoarding
    }
    log(isOnBoardingDone.toString());
  }
}

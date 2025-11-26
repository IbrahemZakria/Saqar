import 'dart:math';

import 'package:adhan/adhan.dart' show PrayerTimes;
import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/praytime.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:workmanager/workmanager.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<void> azkarNotification({
    required bool isActive,
    required int minutes,
  }) async {
    List<String> azkarList = [
      "سُبْحَانَ اللهِ",
      "الْحَمْدُ لِلَّهِ",
      "اللَّهُ أَكْبَرُ",
      "لَا إِلَهَ إِلَّا اللهُ",
      "سُبْحَانَ اللهِ وَبِحَمْدِهِ",
      "سُبْحَانَ اللَّهِ الْعَظِيمِ",
      "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ",
      "سُبْحَانَ رَبِّيَ الْأَعْلَى",
      "سُبْحَانَ رَبِّيَ الْعَظِيمِ",
      "اللَّهُ أَكْبَرُ كَبِيرًا",
      "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
      "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَاللَّهُ أَكْبَرُ",
      "رَبِّ لَا إِلٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ",
      "رَبِّ إِنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ",
      "اللَّهُمَّ آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
      "سُبْحَانَ اللهِ وَبِحَمْدِهِ، سُبْحَانَ رَبِّيَ الْعَظِيمِ",
      "اللَّهُمَّ اهْدِنَا لِلصِّرَاطِ الْمُسْتَقِيمِ",
    ];

    final String body = azkarList[Random().nextInt(azkarList.length)];
    if (isActive) {
      await NotificationServices().showRepetedDurationNotification(
        id: 1,
        title: "ذَكِر",
        body: body,
        time: Duration(minutes: minutes),
      );
    } else {
      NotificationServices().cancelNotification(id: 1);
    }
  }

  @override
  Future<void> eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) async {
    if (isActive) {
      NotificationServices().showDailyNotification(
        id: 2,
        title: "أذكار المساء",
        body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
        scheduledDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).add(Duration(hours: time.inHours, minutes: time.inMinutes % 60)),
      );
      debugPrint('Registered eveningAzkarNotification every day');
    } else {
      NotificationServices().cancelNotification(id: 2);
      debugPrint('Cancelled eveningAzkarNotification');
    }
  }

  @override
  Future<void> morningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) async {
    if (isActive) {
      NotificationServices().showDailyNotification(
        id: 3,
        title: "أذكار الصباح",
        body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
        scheduledDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).add(Duration(hours: time.inHours, minutes: time.inMinutes % 60)),
      );
      debugPrint('Registered morningAzkarNotification every day');
    } else {
      NotificationServices().cancelNotification(id: 3);

      debugPrint('Cancelled morningAzkarNotification');
    }
  }

  @override
  Future<void> prayNotification({required bool isActive}) async {
    if (isActive) {
      Workmanager().registerPeriodicTask(
        "prayNotification",
        "prayNotification",
        tag: "notification",
        frequency: Duration(days: 1),
      );
      debugPrint('Registered prayNotification every day');
    } else {
      Workmanager().cancelByUniqueName("prayNotification");
      debugPrint('Cancelled prayNotification');
    }
  }

  @override
  Future<PrayerTimes> fetchPrayerTimes() async {
    final today = await Praytime.fetchPrayerTimes();
    return today;
  }
}

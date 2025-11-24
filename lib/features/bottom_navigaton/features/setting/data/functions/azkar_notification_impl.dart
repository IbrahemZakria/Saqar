import 'dart:math';

import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/praytime.dart';

class AzkarNotificationImpl {
  static Future<void> azkarNotification() async {
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
    await NotificationServices().showBasicNotification(
      id: 1,
      title: "ذَكِر",
      body: body,
    );
  }

  static Future<void> eveningAzkarNotification({
    required int id,
    required int minute,
    required int hour,
  }) async {
    await NotificationServices().showScheduledNotification(
      id: 2,
      title: "أذكار المساء",
      body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
      scheduledDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).add(Duration(hours: hour, minutes: minute)),
    );
  }

  static Future<void> morningAzkarNotification({
    required int minute,
    required int hour,
    required int id,
  }) async {
    await NotificationServices().showScheduledNotification(
      id: id,
      title: "أذكار الصباح",
      body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
      scheduledDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).add(Duration(hours: hour, minutes: minute)),
    );
  }

  static Future<void> prayNotification() async {
    final praytime = await Praytime.fetchPrayerTimes();

    // اسم الصلاة + وقتها
    final prayers = {
      "الفجر": praytime.fajr,
      "الظهر": praytime.dhuhr,
      "العصر": praytime.asr,
      "المغرب": praytime.maghrib,
      "العشاء": praytime.isha,
    };

    int id = 1; // id مختلف لكل صلاة

    for (var entry in prayers.entries) {
      final prayerName = entry.key; // "الفجر"
      final time = entry.value; // "05:12"

      // تحويل الوقت إلى ساعة ودقيقة

      await NotificationServices().showScheduledNotification(
        id: id,
        title: "موعد صلاة $prayerName",
        body: "حان الآن موعد صلاة $prayerName",
        scheduledDate: time,
      );

      id++; // نزود ID عشان كل إشعار يبقى مختلف
    }
  }
}

import 'dart:developer';

import 'package:atrega/core/helper/functions/pray_notification_services.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/praytime.dart';

class PrayNotificationImpl {
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

    int id = 5; // id مختلف لكل صلاة

    for (var entry in prayers.entries) {
      final prayerName = entry.key; // "الفجر"
      final time = entry.value; // "05:12"
      log(entry.key);

      // تحويل الوقت إلى ساعة ودقيقة

      await PrayNotificationServices().showScheduledNotification(
        id: id,
        title: "موعد صلاة $prayerName",
        body: "حان الآن موعد صلاة $prayerName",
        scheduledDate: time,
      );
    }
  }
}

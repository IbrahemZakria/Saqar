import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class DhikrNotificationService {
  static List<String> azkar = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
    "سبحان الله وبحمده",
    "سبحان الله العظيم",
    "أستغفر الله",
    "اللهم صل على محمد",
    "لا حول ولا قوة إلا بالله",
    "اللهم أعوذ بك من الكسل",
    "اللهم أعوذ بك من الجوع",
    "اللهم أعوذ بك من الخوف",
    "رب اغفر لي",
    "رب اجعلني من الصالحين",
    "اللهم ارزقني حبك وحب من يحبك",
    "اللهم اجعلني من الشاكرين",
    "سبحانك اللهم وبحمدك",
    "اللهم أعني على ذكرك وشكرك",
    "اللهم اجعل عملي خالصاً لوجهك",
    "رب اجعلني من التوابين",
  ];

  /// 🔹 تهيئة القناة
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'dhikr_channel',
        channelName: 'Dhikr Notifications',
        channelDescription: 'Reminders for daily dhikr',
        importance: NotificationImportance.Max,
        defaultColor: const Color(0xFF9D50DD),
        ledColor: const Color(0xFFFFFFFF),
        playSound: false,
        enableVibration: true,
      ),
    ]);

    log("✅ Dhikr Notifications Initialized");
  }

  /// 🔹 جدولة أذكار كل 30 دقيقة بالتتابع وتكرار يومي
  static Future<void> scheduleAzkarLoop() async {
    await AwesomeNotifications().cancelAllSchedules();

    final now = DateTime.now();
    final tz = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    for (int i = 0; i < azkar.length; i++) {
      final scheduleTime = now.add(Duration(minutes: 30 * i));

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1000 + i,
          channelKey: 'dhikr_channel',
          title: "ذكر اليوم",
          body: azkar[i],
          category: NotificationCategory.Reminder,
          displayOnForeground: true,
          displayOnBackground: true,
        ),
        schedule: NotificationCalendar(
          year: scheduleTime.year,
          month: scheduleTime.month,
          day: scheduleTime.day,
          hour: scheduleTime.hour,
          minute: scheduleTime.minute,
          second: 0,
          repeats: true, // 🔹 تكرار يومي
          timeZone: tz,
        ),
      );
    }

    log("📩 Dhikr notifications scheduled every 30 minutes");
  }

  /// 🔹 لإلغاء جميع أذكار
  static Future<void> cancelAllAzkar() async {
    await AwesomeNotifications().cancelAllSchedules();
    log("❌ All Dhikr notifications canceled");
  }
}

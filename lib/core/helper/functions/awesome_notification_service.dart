import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class AwesomeNotificationService {
  /// 🔹 تهيئة القنوات عند تشغيل التطبيق
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'prayer_channel',
        channelName: 'Prayer Notifications',
        channelDescription: 'Prayer times with adhan sound',
        importance: NotificationImportance.Max,
        playSound: true,
        soundSource: 'resource://raw/azan', // 🔹 الصوت المخصص
        defaultColor: const Color(0xFF9D50DD),
        ledColor: const Color(0xFF9D50DD),
        criticalAlerts: true,
      ),
      NotificationChannel(
        channelKey: 'dhikr_channel',
        channelName: 'Dhikr Notifications',
        channelDescription: 'Used for daily dhikr',
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/azan', // 🔹 الصوت المخصص

        channelShowBadge: true,
        defaultColor: const Color(0xFF50DD9D),
        ledColor: const Color(0xFFFFFFFF),
        playSound: true,
        enableVibration: true,
      ),
    ]);

    log("✅ Awesome Notifications Initialized");

    // ضبط الـ listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: AwesomeNotificationService.onActionReceivedMethod,
      onNotificationCreatedMethod: (notification) async {
        log("📩 Notification created: ${notification.title}");
      },
      onNotificationDisplayedMethod: (notification) async {
        log("👁️ Notification displayed: ${notification.title}");
      },
      onDismissActionReceivedMethod: (action) async {
        log("🗑️ Notification dismissed: ${action.id}");
      },
    );
  }

  /// 🔹 صلاحية عرض الإشعارات
  static Future<void> requestPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
      log("✅ Notification permission requested");
    } else {
      log("👍 Notification permission already granted");
    }
  }

  /// 🔔 تشغيل إشعار الصلاة مع زر لإيقاف الصوت
  static Future<void> showPrayerNotification({
    required String title,
    required String body,
    Map<String, String>? payload,
    required int hour,
    required int minute,
  }) async {
    final now = DateTime.now();

    // حدد وقت الإشعار القادم
    DateTime scheduleTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // لو الوقت فات، خليه لليوم اللي بعده
    if (scheduleTime.isBefore(now)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }

    // إنشاء الإشعار المجدول مرة واحدة في اليوم
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(5000),
        channelKey: 'prayer_channel',
        title: title,
        body: body,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: true,
        criticalAlert: true,
        showWhen: true,
        roundedLargeIcon: true,
        category: NotificationCategory.Reminder,
        payload: payload,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'STOP_SOUND',
          label: 'إيقاف الأذان',
          autoDismissible: true,
        ),
      ],
      schedule: NotificationCalendar(
        year: scheduleTime.year,
        month: scheduleTime.month,
        day: scheduleTime.day,
        hour: scheduleTime.hour,
        minute: scheduleTime.minute,
        second: 0,
        millisecond: 0,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        repeats: false, // 🟢 مرّة واحدة فقط
      ),
    );

    log("✅ Prayer notification scheduled for: $scheduleTime");
  }

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
    "رب اجعلني من التوابين",
  ];

  /// 🔔 إشعارات الأذكار اليومية كل 30 دقيقة
  static Future<void> scheduleDailyDhikr() async {
    await AwesomeNotifications().cancelAllSchedules();

    final now = DateTime.now();

    for (int i = 0; i < azkar.length; i++) {
      final scheduleTime = now.add(Duration(minutes: 30));

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1000 + i,
          channelKey: 'dhikr_channel',
          title: 'ذكر اليوم',
          body: azkar[i],
        ),
        schedule: NotificationCalendar(
          year: scheduleTime.year,
          month: scheduleTime.month,
          day: scheduleTime.day,
          hour: scheduleTime.hour,
          minute: scheduleTime.minute,
          second: 0,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          repeats: false,
        ),
      );
    }

    log("📩 Dhikr notifications scheduled sequentially every 5 minutes");
  }

  /// 🔹 Method must be static/global for background
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.buttonKeyPressed == 'STOP_SOUND') {
      log("⛔ Stop azan pressed");
      // هنا ممكن توقف صوت الأذان لو عامل AudioPlayer
    } else {
      log("🖱️ Notification clicked with payload: ${receivedAction.payload}");
    }
  }
}

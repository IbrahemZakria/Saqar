import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PrayNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) {
      print("Error: Scheduled date must be in the future");
      return;
    }
    log("scedual");

    // 1. تأكد من تهيئة timezone أولاً
    tz.initializeTimeZones();

    // 2. احصل على الـ timezone المحلي
    final TimezoneInfo timeZone = await FlutterTimezone.getLocalTimezone();
    final String currentTimeZone = timeZone.identifier;

    // 3. عيّن الـ location
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        icon: '@mipmap/ic_launcher',
        'scheduled_channel',
        'Scheduled Notifications',
        channelDescription: 'Scheduled notifications channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      ), // استخدم tz.local بعد التهيئة
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}

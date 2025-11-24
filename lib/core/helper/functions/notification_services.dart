import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_timezone/timezone_info.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  // -------- Singleton Pattern --------
  static NotificationServices? _instance;
  factory NotificationServices() {
    _instance ??= NotificationServices._internal();
    return _instance!;
  }

  NotificationServices._internal();

  // ------------------------------------

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    print("Background notification tapped: ${notificationResponse.id}");
  }

  Future<void> init() async {
    tz.initializeTimeZones();

    // طلب صلاحيات Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notification tapped: ${response.id}');
      },
    );
  }

  Future<bool> areNotificationsEnabled() async {
    try {
      final androidImpl = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final bool? enabled = await androidImpl?.areNotificationsEnabled();
      if (enabled != null) return enabled;
    } catch (e) {
      print('Error checking Android notification permission: $e');
    }
    return true;
  }

  NotificationDetails _defaultNotificationDetails() {
    return const NotificationDetails(
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
  }

  String getLocalTimeZoneName() {
    try {
      return tz.local.name;
    } catch (_) {
      return 'unknown';
    }
  }

  Future<void> showBasicNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        icon: '@mipmap/ic_launcher',
        "basic_channel",
        "Basic Notifications",
        channelDescription: "Channel for basic notifications",
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

    await flutterLocalNotificationsPlugin.show(id, title, body, details);
  }

  Future<void> showRepeatNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        icon: '@mipmap/ic_launcher',
        'repeat_channel',
        'Repeat Notifications',
        channelDescription: 'Repeating notifications channel',
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

    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
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

  Future<void> cancelNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

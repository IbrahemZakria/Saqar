import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
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
  // -------- Private Static NavigatorKey --------
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  static void notificationTap(NotificationResponse notificationResponse) {
    final int? id = notificationResponse.id;
    switch (id) {
      case 2 || 3:
        final context = _navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).go("/settings");
        }
        break;
      default:
        break;
    }
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
      onDidReceiveBackgroundNotificationResponse: notificationTap,
      onDidReceiveNotificationResponse: notificationTap,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int hour,
    required int minute,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
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

    await flutterLocalNotificationsPlugin.zonedSchedule(
      payload: payload,

      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
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

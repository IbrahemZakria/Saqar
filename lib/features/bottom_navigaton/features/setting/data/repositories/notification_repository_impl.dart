import 'dart:developer';

import 'package:adhan/adhan.dart' show PrayerTimes;
import 'package:flutter/foundation.dart';
import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/praytime.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/azkar_notification_impl.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:workmanager/workmanager.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  void azkarNotification({required bool isActive, required int timefreuency}) {
    if (isActive) {
      Workmanager().registerPeriodicTask(
        "azkar",
        "azkar",
        tag: "notification",
        frequency: Duration(minutes: timefreuency),
      );
      debugPrint('Registered azkar_daily every $timefreuency minutes');
    } else {
      Workmanager().cancelByUniqueName("azkar_daily");
      debugPrint('Cancelled azkar_daily');
    }
  }

  @override
  Future<void> eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) async {
    if (isActive) {
      Workmanager().registerPeriodicTask(
        inputData: {
          "id": 1,
          "hour": time.inHours,
          "minute": time.inMinutes % 60,
        },

        "eveningAzkarNotification",
        "eveningAzkarNotification",
        tag: "notification",
        frequency: Duration(days: 1),
      );
      debugPrint('Registered eveningAzkarNotification every day');
    } else {
      Workmanager().cancelByUniqueName("eveningAzkarNotification");
      debugPrint('Cancelled eveningAzkarNotification');
    }
  }

  @override
  Future<void> morningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) async {
    if (isActive) {
      Workmanager().registerPeriodicTask(
        inputData: {
          "id": 1,
          "hour": time.inHours,
          "minute": time.inMinutes % 60,
        },
        "morningAzkarNotification",
        "morningAzkarNotification",
        tag: "notification",
        frequency: Duration(days: 1),
      );
      debugPrint('Registered morningAzkarNotification every day');
    } else {
      Workmanager().cancelByUniqueName("morningAzkarNotification");
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

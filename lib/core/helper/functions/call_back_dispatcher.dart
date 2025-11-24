import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/data/functions/azkar_notification_impl.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    try {
      log("Callback executed for task: $task");

      final notifications = NotificationServices();
      await notifications.init();

      switch (task) {
        case "morningAzkarNotification":
          log("morningAzkarNotification");
          await AzkarNotificationImpl.morningAzkarNotification(
            hour: inputData?["hour"],
            minute: inputData?["minute"],
            id: inputData?["id"],
          );
          break;

        case "eveningAzkarNotification":
          log("eveningAzkarNotification");
          await AzkarNotificationImpl.eveningAzkarNotification(
            hour: inputData?["hour"],
            minute: inputData?["minute"],
            id: inputData?["id"],
          );
          break;

        case "azkar":
          log("azkar");
          await AzkarNotificationImpl.azkarNotification();
          break;

        case "pray":
          log("pray");
          await AzkarNotificationImpl.prayNotification();
          break;

        default:
          log("Unknown task: $task");
      }

      return Future.value(true);
    } catch (e, st) {
      log('Background task "$task" failed: $e\n$st');
      return Future.value(false);
    }
  });
}

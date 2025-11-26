import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background task: $task");
    // Your background work here
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
void callbackDispatchers() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    log("Callback executed for task: $task");

    try {
      // log("Callback executed for task: $task");

      // // Initialize notifications properly
      // await PrayNotificationServices.init();

      // // Call your notifications
      // await PrayNotificationImpl.prayNotification();

      return Future.value(true);
    } catch (e, st) {
      log('Background task "$task" failed: $e\n$st');
      return Future.value(false);
    }
  });
}

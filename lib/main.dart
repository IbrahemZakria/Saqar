import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/bloc_observer.dart';
import 'package:saqar/core/helper/cubit/pray/pray_cubit.dart';
import 'package:saqar/core/helper/functions/awesome_notification_service.dart';
import 'package:saqar/core/helper/functions/location_services.dart';
import 'package:saqar/saqar_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  if (!kIsWeb) {
    // await LocationServices.getCurrentLocation();
    // await AwesomeNotificationService.initialize();
    // await AwesomeNotificationService.requestPermission();
    // await AwesomeNotificationService.scheduleDailyDhikr();
  }

  runApp(BlocProvider(create: (_) => PrayerCubit(), child: SaqarApp()));
}

import 'package:atrega/atrega.dart';
import 'package:atrega/bloc_observer.dart';
import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  Bloc.observer = MyBlocObserver();
  await NotificationServices().init();
  tz.initializeTimeZones();

  runApp(Atrega());
}

import 'package:atrega/atrega.dart';
import 'package:atrega/bloc_observer.dart';
import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/core/helper/functions/work_manger_services.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  Bloc.observer = MyBlocObserver();

  await Future.wait([NotificationServices().init()]);
  WorkManagerService().init();

  runApp(Atrega());
}

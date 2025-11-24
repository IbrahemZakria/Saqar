import 'package:atrega/core/helper/functions/call_back_dispatcher.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  WorkManagerService._internal();
  static final WorkManagerService _instance = WorkManagerService._internal();
  factory WorkManagerService() => _instance;

  bool _initialized = false;
  final Set<String> _registeredTasks = {};

  bool get isInitialized => _initialized;

  /// Initialize Workmanager once. Calls the existing callback dispatcher.
  Future<void> init() async {
    if (_initialized) return;
    await Workmanager().initialize(callbackDispatcher);
    _initialized = true;
  }

  /// Register a periodic background task.
  /// [uniqueName] is used to identify/cancel the task later.
  /// [taskName] is the name passed to the callback dispatcher (defaults to uniqueName).
  Future<void> registerPeriodicTask({
    required String uniqueName,
    String? taskName,
    Duration frequency = const Duration(hours: 1),
    Map<String, dynamic>? inputData,
  }) async {
    if (!_initialized) await init();
    final tn = taskName ?? uniqueName;
    await Workmanager().registerPeriodicTask(
      uniqueName,
      tn,
      frequency: frequency,
      inputData: inputData,
    );
    _registeredTasks.add(uniqueName);
  }

  /// Register a one-off background task.
  Future<void> registerOneOffTask({
    required String uniqueName,
    String? taskName,
    Duration initialDelay = Duration.zero,
    Map<String, dynamic>? inputData,
  }) async {
    if (!_initialized) await init();
    final tn = taskName ?? uniqueName;
    await Workmanager().registerOneOffTask(
      uniqueName,
      tn,
      initialDelay: initialDelay,
      inputData: inputData,
    );
    _registeredTasks.add(uniqueName);
  }

  /// Cancel a task by its unique name.
  Future<void> cancelByUniqueName(String uniqueName) async {
    await Workmanager().cancelByUniqueName(uniqueName);
    _registeredTasks.remove(uniqueName);
  }

  /// Cancel all registered tasks.
  Future<void> cancelAll() async {
    await Workmanager().cancelAll();
    _registeredTasks.clear();
  }

  /// Check whether a task has been tracked (local cache).
  bool isTaskRegistered(String uniqueName) =>
      _registeredTasks.contains(uniqueName);
}

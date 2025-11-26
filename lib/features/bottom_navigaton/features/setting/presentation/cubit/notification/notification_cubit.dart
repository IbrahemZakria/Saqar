import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class NotificationCubit extends HydratedCubit<NotificationState> {
  NotificationCubit(this.repository) : super(const NotificationState());

  final NotificationRepository repository;

  void azkarNotification({required bool isActive, required int timefreuency}) {
    repository.azkarNotification(isActive: isActive, minutes: timefreuency);
    emit(state.copyWith(dailyAzkar: isActive, dailyInterval: timefreuency));
  }

  void eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    repository.eveningAzkarNotification(isActive: isActive, time: time);
    final tod = TimeOfDay(hour: time.inHours % 24, minute: time.inMinutes % 60);
    emit(state.copyWith(eveningAzkar: isActive, eveningTime: tod));
  }

  void morningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    repository.morningAzkarNotification(isActive: isActive, time: time);
    final tod = TimeOfDay(hour: time.inHours % 24, minute: time.inMinutes % 60);
    emit(state.copyWith(morningAzkar: isActive, morningTime: tod));
  }

  void prayNotification({required bool isActive}) {
    repository.prayNotification(isActive: isActive);
    emit(state.copyWith(adanEnabled: isActive));
  }

  void toggleAdan(bool v) => prayNotification(isActive: v);

  void updateSwitch(String title, bool value, TimeOfDay time) {
    switch (title) {
      case "أذكار الصباح":
        morningAzkarNotification(
          isActive: value,
          time: Duration(hours: time.hour, minutes: time.minute),
        );
        break;
      case "أذكار المساء":
        eveningAzkarNotification(
          isActive: value,
          time: Duration(hours: time.hour, minutes: time.minute),
        );
        break;
      case "أذكار طول اليوم":
        azkarNotification(isActive: value, timefreuency: state.dailyInterval);
        break;
      case "أذان الصلاة":
        prayNotification(isActive: value);
        break;
    }
  }

  // ------------------- Hydration -------------------

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    try {
      return NotificationState(
        morningAzkar: json['morningAzkar'] ?? false,
        eveningAzkar: json['eveningAzkar'] ?? false,
        dailyAzkar: json['dailyAzkar'] ?? false,
        adanEnabled: json['adanEnabled'] ?? false,
        morningTime: TimeOfDay(
          hour: json['morningHour'] ?? 6,
          minute: json['morningMinute'] ?? 30,
        ),
        eveningTime: TimeOfDay(
          hour: json['eveningHour'] ?? 19,
          minute: json['eveningMinute'] ?? 0,
        ),
        dailyInterval: json['dailyInterval'] ?? 30,
      );
    } catch (_) {
      return const NotificationState();
    }
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    return {
      'morningAzkar': state.morningAzkar,
      'eveningAzkar': state.eveningAzkar,
      'dailyAzkar': state.dailyAzkar,
      'adanEnabled': state.adanEnabled,
      'morningHour': state.morningTime.hour,
      'morningMinute': state.morningTime.minute,
      'eveningHour': state.eveningTime.hour,
      'eveningMinute': state.eveningTime.minute,
      'dailyInterval': state.dailyInterval,
    };
  }
}

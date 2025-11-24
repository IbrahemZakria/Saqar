import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(const NotificationState());

  final NotificationRepository repository;

  void azkarNotification({required bool isActive, required int timefreuency}) {
    repository.azkarNotification(
      isActive: isActive,
      timefreuency: timefreuency,
    );
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

  // Convenience used by NotificationIcon
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
}

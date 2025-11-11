import 'package:atrega/core/helper/cubit/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState());

  void toggleMorningAzkar(bool v, [TimeOfDay? time]) {
    emit(
      state.copyWith(morningAzkar: v, morningTime: time ?? state.morningTime),
    );
  }

  void toggleEveningAzkar(bool v, [TimeOfDay? time]) {
    emit(
      state.copyWith(eveningAzkar: v, eveningTime: time ?? state.eveningTime),
    );
  }

  void toggleDailyAzkar(bool v, [int? interval]) {
    emit(
      state.copyWith(
        dailyAzkar: v,
        dailyInterval: interval ?? state.dailyInterval,
      ),
    );
  }

  void toggleAdan(bool v) {
    emit(state.copyWith(adanEnabled: v));
  }

  void updateSwitch(String title, bool value, TimeOfDay time) {
    switch (title) {
      case "أذكار الصباح":
        toggleMorningAzkar(value, time);
        break;
      case "أذكار المساء":
        toggleEveningAzkar(value, time);
        break;
      case "أذكار طول اليوم":
        toggleDailyAzkar(value);
        break;
      case "أذان الصلاة":
        toggleAdan(value);
        break;
    }
  }
}

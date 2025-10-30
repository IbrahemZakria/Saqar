import 'package:adhan/adhan.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final PrayerTimes todayPrayerTimes;
  final PrayerTimes? tomorrowPrayerTimes;
  final bool isAzanPlaying; // 🔹 حالة تشغيل الأذان

  PrayerLoaded({
    required this.todayPrayerTimes,
    this.tomorrowPrayerTimes,
    this.isAzanPlaying = false,
  });

  PrayerLoaded copyWith({bool? isAzanPlaying}) {
    return PrayerLoaded(
      todayPrayerTimes: todayPrayerTimes,
      tomorrowPrayerTimes: tomorrowPrayerTimes,
      isAzanPlaying: isAzanPlaying ?? this.isAzanPlaying,
    );
  }
}

class PrayerError extends PrayerState {
  final String message;
  PrayerError(this.message);
}

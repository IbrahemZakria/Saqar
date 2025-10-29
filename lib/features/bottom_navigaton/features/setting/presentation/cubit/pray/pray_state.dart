// prayer_state.dart

import 'package:adhan/adhan.dart';
import 'package:equatable/equatable.dart';

abstract class PrayerState extends Equatable {
  const PrayerState();
  @override
  List<Object?> get props => [];
}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final PrayerTimes todayPrayerTimes;
  final PrayerTimes tomorrowPrayerTimes;

  const PrayerLoaded({
    required this.todayPrayerTimes,
    required this.tomorrowPrayerTimes,
  });

  @override
  List<Object?> get props => [todayPrayerTimes, tomorrowPrayerTimes];
}

class PrayerError extends PrayerState {
  final String message;
  const PrayerError(this.message);
  @override
  List<Object?> get props => [message];
}

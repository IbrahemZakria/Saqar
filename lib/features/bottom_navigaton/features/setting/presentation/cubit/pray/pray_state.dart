// Prayer state definitions
import 'package:adhan/adhan.dart';
import 'package:equatable/equatable.dart';

abstract class PrayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ------------------ Basic States ------------------

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerError extends PrayerState {
  final String message;
  PrayerError(this.message);

  @override
  List<Object?> get props => [message];
}

// --------------- Prayer Times Loaded ----------------

class PrayerLoaded extends PrayerState {
  final PrayerTimes todayPrayerTimes;

  PrayerLoaded({required this.todayPrayerTimes});

  @override
  List<Object?> get props => [todayPrayerTimes];
}

// ------------------ Switch States -------------------

class AzkarNotificationState extends PrayerState {
  final bool isActive;
  AzkarNotificationState(this.isActive);

  @override
  List<Object?> get props => [isActive];
}

class MorningAzkarState extends PrayerState {
  final bool isActive;
  MorningAzkarState(this.isActive);
}

class EveningAzkarState extends PrayerState {
  final bool isActive;
  EveningAzkarState(this.isActive);
}

class PrayNotificationState extends PrayerState {
  final bool isActive;
  PrayNotificationState(this.isActive);
}

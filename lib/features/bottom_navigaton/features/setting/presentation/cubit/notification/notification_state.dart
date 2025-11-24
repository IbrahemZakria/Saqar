import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NotificationState extends Equatable {
  final bool morningAzkar;
  final bool eveningAzkar;
  final bool dailyAzkar;
  final bool adanEnabled;
  final TimeOfDay morningTime;
  final TimeOfDay eveningTime;
  final int dailyInterval;

  const NotificationState({
    this.morningAzkar = false,
    this.eveningAzkar = false,
    this.dailyAzkar = false,
    this.adanEnabled = false,
    this.morningTime = const TimeOfDay(hour: 6, minute: 30),
    this.eveningTime = const TimeOfDay(hour: 19, minute: 0),
    this.dailyInterval = 30,
  });

  NotificationState copyWith({
    bool? morningAzkar,
    bool? eveningAzkar,
    bool? dailyAzkar,
    bool? adanEnabled,
    TimeOfDay? morningTime,
    TimeOfDay? eveningTime,
    int? dailyInterval,
  }) {
    return NotificationState(
      morningAzkar: morningAzkar ?? this.morningAzkar,
      eveningAzkar: eveningAzkar ?? this.eveningAzkar,
      dailyAzkar: dailyAzkar ?? this.dailyAzkar,
      adanEnabled: adanEnabled ?? this.adanEnabled,
      morningTime: morningTime ?? this.morningTime,
      eveningTime: eveningTime ?? this.eveningTime,
      dailyInterval: dailyInterval ?? this.dailyInterval,
    );
  }

  @override
  List<Object> get props => [
    morningAzkar,
    eveningAzkar,
    dailyAzkar,
    adanEnabled,
    morningTime.hour,
    morningTime.minute,
    eveningTime.hour,
    eveningTime.minute,
    dailyInterval,
  ];
}

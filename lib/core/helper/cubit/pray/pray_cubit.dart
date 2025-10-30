import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saqar/core/helper/functions/awesome_notification_service.dart';
import 'pray_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());

  /// تحميل مواقيت الصلاة اليوم وجدولة الإشعارات
  Future<void> fetchPrayerTimesAndScheduleNotifications() async {
    emit(PrayerLoading());
    try {
      final pos = await _determinePosition();
      final coords = Coordinates(pos.latitude, pos.longitude);

      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      // نحسب اليوم الحالي
      final now = DateTime.now();

      // 🗓️ نحسب 7 أيام قدّام
      for (int i = 0; i < 7; i++) {
        final date = DateComponents.from(now.add(Duration(days: i)));
        final prayers = PrayerTimes(coords, date, params);
        await schedulePrayerNotifications(prayers, i);
      }

      emit(
        PrayerLoaded(
          todayPrayerTimes: PrayerTimes.today(coords, params),
          tomorrowPrayerTimes: PrayerTimes(
            coords,
            DateComponents.from(now.add(const Duration(days: 1))),
            params,
          ),
        ),
      );
    } catch (e) {
      emit(PrayerError(e.toString()));
      log('❌ fetchPrayerTimes failed: $e');
    }
  }

  Future<void> schedulePrayerNotifications(
    PrayerTimes times,
    int dayOffset,
  ) async {
    final prayers = {
      "الفجر": times.fajr,
      "الظهر": times.dhuhr,
      "العصر": times.asr,
      "المغرب": times.maghrib,
      "العشاء": times.isha,
    };

    for (final entry in prayers.entries) {
      final time = entry.value;
      await AwesomeNotificationService.showPrayerNotification(
        title: "وقت الصلاة",
        body: "حان الآن موعد صلاة ${entry.key}",
        hour: time.hour,
        minute: time.minute,
        payload: {"prayer": entry.key, "dayOffset": "$dayOffset"},
      );
    }
  }

  /// الحصول على الموقع الحالي
  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw 'Location services are disabled.';

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

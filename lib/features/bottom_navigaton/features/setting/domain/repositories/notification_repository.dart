import 'package:adhan/adhan.dart';

abstract class NotificationRepository {
  void azkarNotification({required bool isActive, required int timefreuency});
  void morningAzkarNotification({
    required bool isActive,
    required Duration time,
  });
  void eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  });
  void prayNotification({required bool isActive});
  Future<PrayerTimes> fetchPrayerTimes();
}

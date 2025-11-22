import 'package:adhan/adhan.dart';

abstract class PrayerRepositoryContract {
  Future<PrayerTimes> getTodayPrayerTimes();
  Future<PrayerTimes> getTomorrowPrayerTimes();
}

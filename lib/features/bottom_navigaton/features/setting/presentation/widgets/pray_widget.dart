// top_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/prayer_carousel.dart';

class PrayWidget extends StatelessWidget {
  final DateTime now;
  final PrayerTimes todayPrayerTimes;
  final PrayerTimes? tomorrowPrayerTimes;

  const PrayWidget({
    super.key,
    required this.now,
    required this.todayPrayerTimes,
    this.tomorrowPrayerTimes,
  });

  Map<String, DateTime> _buildPrayerMap() {
    return {
      'الفجر': todayPrayerTimes.fajr,
      'الظهر': todayPrayerTimes.dhuhr,
      'العصر': todayPrayerTimes.asr,
      'المغرب': todayPrayerTimes.maghrib,
      'العشاء': todayPrayerTimes.isha,
    };
  }

  MapEntry<String, DateTime>? _nextPrayerEntry() {
    final map = _buildPrayerMap();
    final entries = map.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    for (final e in entries) {
      if (now.isBefore(e.value)) return e;
    }

    if (tomorrowPrayerTimes != null) {
      return MapEntry('Fajr', tomorrowPrayerTimes!.fajr);
    }
    return null;
  }

  String _formatDurationUntil(DateTime dt) {
    Duration diff = dt.difference(now);
    if (diff.isNegative) diff = Duration.zero;
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final next = _nextPrayerEntry();

    final time = next!.value;
    final remaining = _formatDurationUntil(time);

    final miladDate = DateFormat('d MMMM، y', 'ar').format(DateTime.now());

    // التاريخ الهجري
    final hijriDate = HijriCalendar.fromDate(DateTime.now());
    final formattedHijri =
        '${hijriDate.hDay} ${hijriDate.longMonthName}، ${hijriDate.hYear} هـ';

    // اليوم بالعربية
    final dayName = DateFormat('EEEE', 'ar').format(DateTime.now());
    final prayersMap = _buildPrayerMap();
    final nextPrayer = _nextPrayerEntry();

    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kprimarycolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    textAlign: TextAlign.center,

                    miladDate.toString(),
                    style: AppTextSyles.textStyle16se(
                      context,
                    ).copyWith(color: Colors.black54),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Pray Time\n\n$dayName",
                    style: AppTextSyles.textStyle16se(
                      context,
                    ).copyWith(color: Colors.black54),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    textAlign: TextAlign.center,

                    formattedHijri.toString(),
                    style: AppTextSyles.textStyle16se(
                      context,
                    ).copyWith(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          PrayerCarousel(
            prayersMap: prayersMap,
            currentPrayerName: nextPrayer?.key ?? 'الفجر',
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                remaining,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                ' - الصلاه القادمه',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

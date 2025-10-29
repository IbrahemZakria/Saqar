import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PrayerCarousel extends StatelessWidget {
  final Map<String, DateTime> prayersMap;
  final String currentPrayerName;

  const PrayerCarousel({
    super.key,
    required this.prayersMap,
    required this.currentPrayerName,
  });

  @override
  Widget build(BuildContext context) {
    final prayerEntries = prayersMap.entries.toList();
    final timeFmt = DateFormat.jm('ar');
    final height = MediaQuery.sizeOf(context).height;

    // تحديد الصلاة الحالية لبدء الكاروسيل منها
    final currentIndex = prayerEntries.indexWhere(
      (e) => e.key == currentPrayerName,
    );

    return CarouselSlider(
      options: CarouselOptions(
        height: height * .15,
        enlargeCenterPage: true,
        initialPage: currentIndex >= 0 ? currentIndex : 0,
        enableInfiniteScroll: false,
        viewportFraction: .4,
      ),
      items: prayerEntries.map((entry) {
        final isActive = entry.key == currentPrayerName;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xffB19768),
                Color(0xFF202020), // بني غامق (تقدر تغير الدرجة)
              ],
              stops: [0.1, 1.0],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: isActive ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timeFmt.format(entry.value),
                  style: TextStyle(
                    fontSize: isActive ? 20 : 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

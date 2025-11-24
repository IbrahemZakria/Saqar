import 'package:adhan/adhan.dart'
    show
        Coordinates,
        CalculationMethod,
        CalculationMethodExtensions,
        Madhab,
        PrayerTimes;

import 'package:geolocator/geolocator.dart';

class Praytime {
  static Future<Position> _determinePosition() async {
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
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  static Future<PrayerTimes> fetchPrayerTimes() async {
    final pos = await _determinePosition();
    final coords = Coordinates(pos.latitude, pos.longitude);

    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final today = PrayerTimes.today(coords, params);
    return today;
  }
}

import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/repositories/prayer_repository.dart';

class PrayerRepositoryImpl implements PrayerRepositoryContract {
  /// Returns today's prayer times using device location.
  @override
  Future<PrayerTimes> getTodayPrayerTimes() async {
    final pos = await _determinePosition();
    final coords = Coordinates(pos.latitude, pos.longitude);

    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final today = PrayerTimes.today(coords, params);
    return today;
  }

  @override
  Future<PrayerTimes> getTomorrowPrayerTimes() async {
    final pos = await _determinePosition();
    final coords = Coordinates(pos.latitude, pos.longitude);

    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final tomorrow = PrayerTimes(
      coords,
      DateComponents.from(DateTime.now().add(const Duration(days: 1))),
      params,
    );
    return tomorrow;
  }

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

    return await Geolocator.getCurrentPosition();
  }
}

// prayer_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());

  Future<void> fetchPrayerTimes() async {
    emit(PrayerLoading());

    try {
      final pos = await _determinePosition();
      final coords = Coordinates(pos.latitude, pos.longitude);

      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final today = PrayerTimes.today(coords, params);
      final tomorrow = PrayerTimes(
        coords,
        DateComponents.from(DateTime.now().add(const Duration(days: 1))),
        params,
      );

      emit(
        PrayerLoaded(todayPrayerTimes: today, tomorrowPrayerTimes: tomorrow),
      );
    } catch (e) {
      emit(PrayerError(e.toString()));
    }
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

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit(this.repository) : super(PrayerInitial());
  final NotificationRepository repository;

  Future<void> fetchPrayerTimes() async {
    emit(PrayerLoading());

    try {
      final today = await repository.fetchPrayerTimes();
      emit(PrayerLoaded(todayPrayerTimes: today));
    } catch (e) {
      emit(PrayerError(e.toString()));
    }
  }

  void azkarNotification({required bool isActive, required int timefreuency}) {
    repository.azkarNotification(
      isActive: isActive,
      timefreuency: timefreuency,
    );
  }

  void eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    repository.eveningAzkarNotification(isActive: isActive, time: time);
  }

  void morningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    repository.morningAzkarNotification(isActive: isActive, time: time);
  }

  void prayNotification(bool v, {required bool isActive}) {
    repository.prayNotification(isActive: isActive);
  }
}

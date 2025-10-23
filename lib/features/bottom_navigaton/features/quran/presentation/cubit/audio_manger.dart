import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_player/quran_player_cubit.dart';

class AudioManager {
  QuranPlayerCubit? _currentCubit;

  void setCurrent(QuranPlayerCubit cubit) {
    if (_currentCubit != null && _currentCubit != cubit) {
      _currentCubit!.pause(); // يوقف الصوت السابق
    }
    _currentCubit = cubit;
  }
}

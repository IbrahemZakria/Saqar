import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'quran_player_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  final AudioPlayer _player = AudioPlayer();

  QuranPlayerCubit() : super(QuranPlayerInitial());

  Future<void> playByNumber(String number) async {
    emit(QuranPlayerLoading());
    try {
      // تأكد أن الرقم ثلاث خانات
      String formattedNumber = number.padLeft(3, '0');

      String url = 'https://server9.mp3quran.net/akrm/$formattedNumber.mp3';

      await _player.setUrl(url);
      _player.play();
      emit(QuranPlayerPlaying());

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          emit(QuranPlayerStopped());
        }
      });
    } catch (e) {
      emit(QuranPlayerError(e.toString()));
    }
  }

  void pause() {
    _player.pause();
    emit(QuranPlayerPaused());
  }

  void resume() {
    _player.play();
    emit(QuranPlayerPlaying());
  }

  void stop() {
    _player.stop();
    emit(QuranPlayerStopped());
  }

  @override
  Future<void> close() {
    _player.pause(); // أو _player.stop();
    _player.dispose();
    return super.close();
  }
}

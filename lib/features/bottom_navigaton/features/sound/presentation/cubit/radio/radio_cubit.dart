import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/data/repos/radio_repository.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/radio_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_state.dart';

class RadioCubit
    extends Cubit<({RadioLoadState load, RadioPlayerState player})> {
  final RadioRepository repository;
  final AudioPlayer _player = AudioPlayer();

  RadioCubit(this.repository)
    : super((load: RadioInitial(), player: const RadioPlayerState())) {
    _listenToAudio();
  }

  // 🟢 تحميل قائمة الإذاعات من الـ API
  Future<void> fetchRadios() async {
    emit((load: RadioLoading(), player: state.player));
    try {
      final List<RadioEntity> radios = await repository.fetchRadios();
      emit((load: RadioLoaded(radios), player: state.player));
    } catch (e) {
      emit((load: RadioError(e.toString()), player: state.player));
    }
  }

  // 🎧 تشغيل / إيقاف إذاعة
  Future<void> playRadio(RadioEntity radio) async {
    final current = state.player.currentRadio;

    // لو غيرنا الإذاعة
    if (current == null || current.id != radio.id) {
      await _player.stop();
      await _player.setUrl(radio.url);
      emit((
        load: state.load,
        player: state.player.copyWith(currentRadio: radio, isPlaying: true),
      ));
      await _player.play();
    } else {
      // نفس الإذاعة
      if (state.player.isPlaying) {
        await _player.pause();
        emit((
          load: state.load,
          player: state.player.copyWith(isPlaying: false),
        ));
      } else {
        emit((
          load: state.load,
          player: state.player.copyWith(isPlaying: true),
        ));
        await _player.play();
      }
    }
  }

  // 🔴 إيقاف الصوت
  Future<void> stopRadio() async {
    await _player.stop();
    emit((load: state.load, player: state.player.copyWith(isPlaying: false)));
  }

  // 🔄 متابعة حالة الصوت
  void _listenToAudio() {
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      emit((
        load: state.load,
        player: state.player.copyWith(isPlaying: isPlaying),
      ));
    });

    // لو حابب تضيف progress كمان:
    _player.positionStream.listen((pos) {
      emit((load: state.load, player: state.player.copyWith(position: pos)));
    });
    _player.durationStream.listen((dur) {
      if (dur != null) {
        emit((load: state.load, player: state.player.copyWith(total: dur)));
      }
    });
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}

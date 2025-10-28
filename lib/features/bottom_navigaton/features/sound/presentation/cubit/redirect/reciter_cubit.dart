import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/data/repos/reciters_repo_impl.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_state.dart';

class ReciterCubit
    extends Cubit<({ReciterLoadState load, ReciterPlayerState player})> {
  final RecitersRepoImpl _repo;
  final AudioPlayer _player = AudioPlayer();

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  ReciterCubit(this._repo)
    : super((load: ReciterInitial(), player: ReciterPlayerInitial())) {
    // ✅ لما السورة تخلص
    _player.onPlayerComplete.listen((_) {
      emit((load: state.load, player: ReciterPlayerStopped()));
    });

    // ✅ تحديث الزمن الكلي
    _player.onDurationChanged.listen((d) {
      _duration = d;
      _updatePositionState(force: true);
    });

    // ✅ تحديث موقع الصوت بشكل سلس
    _player.onPositionChanged.listen((p) {
      _position = p;
      _updatePositionState();
    });
  }

  // 🔄 لتحديث الحالة بدون lag
  void _updatePositionState({bool force = false}) {
    final currentPlayer = state.player;
    if (currentPlayer is ReciterPlayerPlaying) {
      final oldPos = currentPlayer.position;
      final diff = (_position - oldPos).inMilliseconds.abs();

      if (force || diff > 800) {
        emit((
          load: state.load,
          player: currentPlayer.copyWith(
            duration: _duration,
            position: _position,
          ),
        ));
      }
    }
  }

  Future<void> fetchReciters() async {
    emit((load: ReciterLoading(), player: state.player));
    try {
      final reciters = await _repo.fetchReciters();
      emit((load: ReciterLoaded(reciters), player: state.player));
    } catch (e) {
      emit((load: ReciterError(e.toString()), player: state.player));
    }
  }

  Future<void> playSound({
    required String url,
    required ReciterEntity reciter,
    required int surahId,
  }) async {
    // لو الحالة الحالية هي Paused هنكمل من المكان اللي وقف عنده
    if (state.player is ReciterPlayerPaused) {
      final pausedState = state.player as ReciterPlayerPaused;
      await _player.resume();

      emit((
        load: state.load,
        player: ReciterPlayerPlaying(
          url: url,
          currentReciter: pausedState.currentReciter,
          currentSuraId: pausedState.currentSuraId,
          duration: pausedState.duration,
          position: pausedState.position,
        ),
      ));
      return;
    }

    // تشغيل جديد من البداية
    await _player.stop();
    await _player.play(UrlSource(url));

    emit((
      load: state.load,
      player: ReciterPlayerPlaying(
        url: url,
        currentReciter: reciter,
        currentSuraId: surahId,
      ),
    ));
  }

  Future<void> pauseSound() async {
    if (state.player is! ReciterPlayerPlaying) return;

    final playingState = state.player as ReciterPlayerPlaying;
    final position = await _player.getCurrentPosition() ?? Duration.zero;
    final duration = await _player.getDuration() ?? Duration.zero;

    await _player.pause();

    emit((
      load: state.load,
      player: ReciterPlayerPaused(
        currentReciter: playingState.currentReciter,
        currentSuraId: playingState.currentSuraId,
        position: position,
        duration: duration,
      ),
    ));
  }

  Future<void> stopSound() async {
    await _player.stop();
    emit((load: state.load, player: ReciterPlayerStopped()));
  }

  Future<void> seekTo(Duration position) async {
    await _player.seek(position);
  }

  Future<void> forward5Seconds() async {
    final newPos = _position + const Duration(seconds: 5);
    await _player.seek(newPos < _duration ? newPos : _duration);
  }

  Future<void> rewind5Seconds() async {
    final newPos = _position - const Duration(seconds: 5);
    await _player.seek(newPos < Duration.zero ? Duration.zero : newPos);
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}

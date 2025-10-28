import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';

/// ----------------------
/// 📘 تحميل القراء
/// ----------------------
abstract class ReciterLoadState {}

class ReciterInitial extends ReciterLoadState {}

class ReciterLoading extends ReciterLoadState {}

class ReciterLoaded extends ReciterLoadState {
  final List<ReciterEntity> reciters;
  ReciterLoaded(this.reciters);
}

class ReciterError extends ReciterLoadState {
  final String message;
  ReciterError(this.message);
}

/// ----------------------
/// 🎧 حالة الصوت
/// ----------------------
abstract class ReciterPlayerState {}

class ReciterPlayerInitial extends ReciterPlayerState {}

class ReciterPlayerPlaying extends ReciterPlayerState {
  final String url;
  final ReciterEntity? currentReciter;
  final int? currentSuraId;
  final Duration duration;
  final Duration position;

  ReciterPlayerPlaying({
    required this.url,
    this.currentReciter,
    this.currentSuraId,
    this.duration = Duration.zero,
    this.position = Duration.zero,
  });

  ReciterPlayerPlaying copyWith({
    String? url,
    ReciterEntity? currentReciter,
    int? currentSuraId,
    Duration? duration,
    Duration? position,
  }) {
    return ReciterPlayerPlaying(
      url: url ?? this.url,
      currentReciter: currentReciter ?? this.currentReciter,
      currentSuraId: currentSuraId ?? this.currentSuraId,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }
}

/// 🟡 حالة الإيقاف المؤقت (Pause)
class ReciterPlayerPaused extends ReciterPlayerState {
  final ReciterEntity? currentReciter;
  final int? currentSuraId;
  final Duration duration;
  final Duration position;

  ReciterPlayerPaused({
    this.currentReciter,
    this.currentSuraId,
    this.duration = Duration.zero,
    this.position = Duration.zero,
  });
}

/// 🔴 حالة التوقف الكامل
class ReciterPlayerStopped extends ReciterPlayerState {}

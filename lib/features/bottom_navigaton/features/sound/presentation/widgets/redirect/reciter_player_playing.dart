import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_state.dart';

class ReciterPlayerPlaying extends ReciterPlayerState {
  final String url;
  final ReciterEntity? currentReciter;
  final int currentSuraId;
  final Duration duration;
  final Duration position;

  ReciterPlayerPlaying({
    required this.url,
    required this.currentReciter,
    required this.currentSuraId,
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

import 'package:equatable/equatable.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/radio_entity.dart';

/// 🟩 حالات تحميل الإذاعات من API
abstract class RadioLoadState extends Equatable {
  const RadioLoadState();

  @override
  List<Object?> get props => [];
}

class RadioInitial extends RadioLoadState {}

class RadioLoading extends RadioLoadState {}

class RadioLoaded extends RadioLoadState {
  final List<RadioEntity> radios;
  const RadioLoaded(this.radios);

  @override
  List<Object?> get props => [radios];
}

class RadioError extends RadioLoadState {
  final String message;
  const RadioError(this.message);

  @override
  List<Object?> get props => [message];
}

/// 🎧 حالة تشغيل الصوت
class RadioPlayerState extends Equatable {
  final RadioEntity? currentRadio;
  final bool isPlaying;
  final Duration position;
  final Duration total;

  const RadioPlayerState({
    this.currentRadio,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.total = Duration.zero,
  });

  RadioPlayerState copyWith({
    RadioEntity? currentRadio,
    bool? isPlaying,
    Duration? position,
    Duration? total,
  }) {
    return RadioPlayerState(
      currentRadio: currentRadio ?? this.currentRadio,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [currentRadio, isPlaying, position, total];
}

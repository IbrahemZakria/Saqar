part of 'quran_player_cubit.dart';

abstract class QuranPlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuranPlayerInitial extends QuranPlayerState {}

class QuranPlayerLoading extends QuranPlayerState {}

class QuranPlayerPlaying extends QuranPlayerState {}

class QuranPlayerPaused extends QuranPlayerState {}

class QuranPlayerStopped extends QuranPlayerState {}

class QuranPlayerError extends QuranPlayerState {
  final String message;
  QuranPlayerError(this.message);
  @override
  List<Object?> get props => [message];
}

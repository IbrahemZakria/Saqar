part of 'quran_cubit.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranSearchState extends QuranState {
  final List<SuraEntity> suras;
  QuranSearchState(this.suras);
}

class QuranLoadingSura extends QuranState {}

class QuranSuraLoaded extends QuranState {
  final SuraEntity sura;
  final List<String> verses;
  QuranSuraLoaded({required this.sura, required this.verses});
}

class QuranSuraError extends QuranState {
  final String message;
  QuranSuraError({required this.message});
}

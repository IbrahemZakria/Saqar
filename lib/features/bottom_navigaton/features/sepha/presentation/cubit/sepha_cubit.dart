import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_state.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  TasbeehCubit()
    : super(const TasbeehState(count: 0, angle: 0, currentIndex: 0));

  final List<String> azkar = [
    "سُبْحَانَ اللهِ",
    "الْـحَمْـدُ للهِ",
    "اللّٰهُ أَكْبَرُ",
  ];

  void onTap() {
    int newCount = state.count + 1;
    double newAngle = state.angle + pi * 0.5;
    int newIndex = state.currentIndex;

    if (newCount >= 33) {
      newCount = 0;
      newIndex = (state.currentIndex + 1) % azkar.length;
    }

    emit(
      state.copyWith(count: newCount, angle: newAngle, currentIndex: newIndex),
    );
  }

  String get currentZikr => azkar[state.currentIndex];
}

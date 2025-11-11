import 'package:equatable/equatable.dart';

class TasbeehState extends Equatable {
  final int count;
  final double angle;
  final int currentIndex;

  const TasbeehState({
    required this.count,
    required this.angle,
    required this.currentIndex,
  });

  TasbeehState copyWith({int? count, double? angle, int? currentIndex}) {
    return TasbeehState(
      count: count ?? this.count,
      angle: angle ?? this.angle,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [count, angle, currentIndex];
}

import 'package:equatable/equatable.dart';

class TasbeehState extends Equatable {
  final String selectedCategory;
  final String selectedZikr;
  final Map<String, int> counts; // 🔹 لكل ذكر عداده الخاص

  const TasbeehState({
    required this.selectedCategory,
    required this.selectedZikr,
    required this.counts,
  });

  TasbeehState copyWith({
    String? selectedCategory,
    String? selectedZikr,
    Map<String, int>? counts,
  }) {
    return TasbeehState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedZikr: selectedZikr ?? this.selectedZikr,
      counts: counts ?? this.counts,
    );
  }

  @override
  List<Object> get props => [selectedCategory, selectedZikr, counts];

  Map<String, dynamic> toMap() => {
    'selectedCategory': selectedCategory,
    'selectedZikr': selectedZikr,
    'counts': counts,
  };

  factory TasbeehState.fromMap(Map<String, dynamic> m) => TasbeehState(
    selectedCategory: m['selectedCategory'] as String,
    selectedZikr: m['selectedZikr'] as String,
    counts: Map<String, int>.from(m['counts'] as Map),
  );
}

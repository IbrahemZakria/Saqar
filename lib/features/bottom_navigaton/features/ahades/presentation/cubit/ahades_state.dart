class AhadesState {
  final List<Map<String, String>> ahadith;
  final bool isLoading;
  final String? error;

  AhadesState({this.ahadith = const [], this.isLoading = false, this.error});

  AhadesState copyWith({
    List<Map<String, String>>? ahadith,
    bool? isLoading,
    String? error,
  }) {
    return AhadesState(
      ahadith: ahadith ?? this.ahadith,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

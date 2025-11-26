import 'package:atrega/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class TasbeehCubit extends HydratedCubit<TasbeehState> {
  TasbeehCubit()
    : super(
        const TasbeehState(
          selectedCategory: 'أذكار الصلاة',
          selectedZikr: '',
          counts: {},
        ),
      );

  final List<String> prayerAzkar = [
    'سُبْحَانَ الله',
    'الْحَمْدُ لله',
    'اللّٰهُ أَكْبَرُ',
    'لَا إِلَـٰهَ إِلَّا اللّٰهُ',
  ];

  final List<String> choiceAzkar = [
    'أستغفر الله',
    'سبحان الله وبحمده',
    'لا حول ولا قوة إلا بالله',
    'سبحان الله العظيم',
  ];
  void changeCategory(String category) {
    if (category == 'أذكار الصلاة') {
      emit(
        state.copyWith(
          selectedCategory: category,
          selectedZikr: prayerAzkar[0], // نبدأ بالذكر الأول تلقائيًا
        ),
      );
    } else if (category == 'اختيارات الأذكار') {
      emit(
        state.copyWith(
          selectedCategory: category,
          selectedZikr: choiceAzkar[0], // أو تترك فارغ إذا تحب
        ),
      );
    }
  }

  void selectChoiceZikr(String zikr) =>
      emit(state.copyWith(selectedZikr: zikr));

  void increment() {
    final current = currentZikr;
    final threshold = current == 'لَا إِلَـٰهَ إِلَّا اللّٰهُ' ? 1 : 33;

    final currentCount = state.counts[current] ?? 0;
    final newCount = currentCount + 1;

    final updatedCounts = Map<String, int>.from(state.counts);
    if (newCount >= threshold) {
      updatedCounts[current] = 0;
      // الانتقال للذكر التالي فقط لأذكار الصلاة
      if (state.selectedCategory == 'أذكار الصلاة') {
        final nextIndex =
            (prayerAzkar.indexOf(current) + 1) % prayerAzkar.length;
        emit(
          state.copyWith(
            counts: updatedCounts,
            selectedZikr: prayerAzkar[nextIndex],
          ),
        );
      } else {
        updatedCounts[current] = 0;
        emit(state.copyWith(counts: updatedCounts));
      }
    } else {
      updatedCounts[current] = newCount;
      emit(state.copyWith(counts: updatedCounts));
    }
  }

  void reset() {
    final updatedCounts = Map<String, int>.from(state.counts);
    final current = currentZikr;
    updatedCounts[current] = 0;
    emit(state.copyWith(counts: updatedCounts));
  }

  String get currentZikr {
    if (state.selectedCategory == 'أذكار الصلاة') {
      if (state.selectedZikr.isEmpty) return prayerAzkar[0];
      return state.selectedZikr;
    }
    if (state.selectedZikr.isEmpty) return choiceAzkar[0];
    return state.selectedZikr;
  }

  int get currentCount => state.counts[currentZikr] ?? 0;

  @override
  TasbeehState? fromJson(Map<String, dynamic> json) {
    try {
      return TasbeehState.fromMap(json.cast<String, dynamic>());
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TasbeehState state) => state.toMap();
}

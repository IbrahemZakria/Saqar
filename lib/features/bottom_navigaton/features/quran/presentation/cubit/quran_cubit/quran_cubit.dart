import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:atrega/core/utils/quran.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  final TextEditingController searchController = TextEditingController();

  List<SuraEntity> filteredSuras = [];

  String normalizeText(String text) {
    // 🔹 إزالة التشكيل العربي
    final diacritics = RegExp(r'[\u0617-\u061A\u064B-\u0652]');
    // 🔹 إزالة كل الرموز الغريبة (زي الفواصل، الشرط، الأقواس، إلخ)
    final symbols = RegExp(r'[^\w\s\u0600-\u06FF]');
    // 🔹 حوّل النص لحروف صغيرة ونظّفه
    return text
        .replaceAll(diacritics, '')
        .replaceAll(symbols, '')
        .toLowerCase()
        .trim();
  }

  void searchSuras(String query) {
    final lowerQuery = query.trim().toLowerCase();
    if (lowerQuery.isEmpty) {
      filteredSuras = quranSuras;
    } else {
      filteredSuras = quranSuras.where((sura) {
        final ar = normalizeText(sura.arName).replaceAll(" ", "").toLowerCase();
        final en = normalizeText(sura.enName).replaceAll(" ", "").toLowerCase();
        return ar.contains(lowerQuery) || en.contains(lowerQuery);
      }).toList();
    }
    emit(QuranSearchState(filteredSuras));
  }

  void loadAllSuras() {
    filteredSuras = quranSuras;
    emit(QuranSearchState(filteredSuras));
  }

  Future<void> loadSuraText(SuraEntity sura) async {
    try {
      emit(QuranLoadingSura());
      final totalVerses = quran.getVerseCount(sura.id);
      List<String> verses = [];
      for (int i = 1; i <= totalVerses; i++) {
        verses.add(quran.getVerse(sura.id, i));
      }
      emit(QuranSuraLoaded(sura: sura, verses: verses));
    } catch (e) {
      emit(QuranSuraError(message: e.toString()));
    }
  }
}

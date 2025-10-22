import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  final TextEditingController searchController = TextEditingController();

  final List<SuraEntity> quranSuras = [
    SuraEntity(
      arName: "الفَاتِحَة",
      enName: "Al-Fatihah",
      id: 1,
      versesCount: 7,
    ),
    SuraEntity(
      arName: "البَقَرَة",
      enName: "Al-Baqarah",
      id: 2,
      versesCount: 286,
    ),
    SuraEntity(
      arName: "آلِ عِمْرَان",
      enName: "Aal-Imran",
      id: 3,
      versesCount: 200,
    ),
    SuraEntity(arName: "النِّسَاء", enName: "An-Nisa", id: 4, versesCount: 176),
    SuraEntity(
      arName: "المَائِدَة",
      enName: "Al-Ma'idah",
      id: 5,
      versesCount: 120,
    ),
    SuraEntity(
      arName: "الأنْعَام",
      enName: "Al-An'am",
      id: 6,
      versesCount: 165,
    ),
    SuraEntity(
      arName: "الأَعْرَاف",
      enName: "Al-A'raf",
      id: 7,
      versesCount: 206,
    ),
    SuraEntity(arName: "الأنْفَال", enName: "Al-Anfal", id: 8, versesCount: 75),
    SuraEntity(
      arName: "التَّوْبَة",
      enName: "At-Tawbah",
      id: 9,
      versesCount: 129,
    ),
    SuraEntity(arName: "يُونُس", enName: "Yunus", id: 10, versesCount: 109),
    SuraEntity(arName: "هُود", enName: "Hud", id: 11, versesCount: 123),
    SuraEntity(arName: "يُوسُف", enName: "Yusuf", id: 12, versesCount: 111),
    SuraEntity(arName: "الرَّعْد", enName: "Ar-Ra'd", id: 13, versesCount: 43),
    SuraEntity(
      arName: "إِبْرَاهِيم",
      enName: "Ibrahim",
      id: 14,
      versesCount: 52,
    ),
    SuraEntity(arName: "الحِجْر", enName: "Al-Hijr", id: 15, versesCount: 99),
    SuraEntity(arName: "النَّحْل", enName: "An-Nahl", id: 16, versesCount: 128),
    SuraEntity(
      arName: "الإسْرَاءِ",
      enName: "Al-Isra",
      id: 17,
      versesCount: 111,
    ),
    SuraEntity(arName: "الكَهْف", enName: "Al-Kahf", id: 18, versesCount: 110),
    SuraEntity(arName: "مَرْيَم", enName: "Maryam", id: 19, versesCount: 98),
    SuraEntity(arName: "طٰه", enName: "Taha", id: 20, versesCount: 135),
    SuraEntity(
      arName: "الأنْبِيَاء",
      enName: "Al-Anbiya",
      id: 21,
      versesCount: 112,
    ),
    SuraEntity(arName: "الحَجّ", enName: "Al-Hajj", id: 22, versesCount: 78),
    SuraEntity(
      arName: "المُؤْمِنُون",
      enName: "Al-Mu’minun",
      id: 23,
      versesCount: 118,
    ),
    SuraEntity(arName: "النُّور", enName: "An-Nur", id: 24, versesCount: 64),
    SuraEntity(
      arName: "الفُرْقَان",
      enName: "Al-Furqan",
      id: 25,
      versesCount: 77,
    ),
    SuraEntity(
      arName: "الشُّعَرَاء",
      enName: "Ash-Shu'ara",
      id: 26,
      versesCount: 227,
    ),
    SuraEntity(arName: "النَّمْل", enName: "An-Naml", id: 27, versesCount: 93),
    SuraEntity(arName: "القَصَص", enName: "Al-Qasas", id: 28, versesCount: 88),
    SuraEntity(
      arName: "العَنكَبُوت",
      enName: "Al-Ankabut",
      id: 29,
      versesCount: 69,
    ),
    SuraEntity(arName: "الرُّوم", enName: "Ar-Rum", id: 30, versesCount: 60),
    SuraEntity(arName: "لُقْمَان", enName: "Luqman", id: 31, versesCount: 34),
    SuraEntity(
      arName: "السَّجْدَة",
      enName: "As-Sajdah",
      id: 32,
      versesCount: 30,
    ),
    SuraEntity(
      arName: "الأَحْزَاب",
      enName: "Al-Ahzab",
      id: 33,
      versesCount: 73,
    ),
    SuraEntity(arName: "سَبَأ", enName: "Saba", id: 34, versesCount: 54),
    SuraEntity(arName: "فَاطِر", enName: "Fatir", id: 35, versesCount: 45),
    SuraEntity(arName: "يَس", enName: "Ya-Sin", id: 36, versesCount: 83),
    SuraEntity(
      arName: "الصَّافَّات",
      enName: "As-Saffat",
      id: 37,
      versesCount: 182,
    ),
    SuraEntity(arName: "صَ", enName: "Sad", id: 38, versesCount: 88),
    SuraEntity(arName: "الزُّمَر", enName: "Az-Zumar", id: 39, versesCount: 75),
    SuraEntity(arName: "غَافِر", enName: "Ghafir", id: 40, versesCount: 85),
    SuraEntity(
      arName: "فُصِّلَتْ",
      enName: "Fussilat",
      id: 41,
      versesCount: 54,
    ),
    SuraEntity(
      arName: "الشُّورَى",
      enName: "Ash-Shura",
      id: 42,
      versesCount: 53,
    ),
    SuraEntity(
      arName: "الزُّخْرُف",
      enName: "Az-Zukhruf",
      id: 43,
      versesCount: 89,
    ),
    SuraEntity(
      arName: "الدُّخَان",
      enName: "Ad-Dukhan",
      id: 44,
      versesCount: 59,
    ),
    SuraEntity(
      arName: "الجَاثِيَة",
      enName: "Al-Jathiyah",
      id: 45,
      versesCount: 37,
    ),
    SuraEntity(
      arName: "الأَحْقَاف",
      enName: "Al-Ahqaf",
      id: 46,
      versesCount: 35,
    ),
    SuraEntity(arName: "مُحَمَّد", enName: "Muhammad", id: 47, versesCount: 38),
    SuraEntity(arName: "الفَتْح", enName: "Al-Fath", id: 48, versesCount: 29),
    SuraEntity(
      arName: "الحُجُرَات",
      enName: "Al-Hujurat",
      id: 49,
      versesCount: 18,
    ),
    SuraEntity(arName: "قَ", enName: "Qaf", id: 50, versesCount: 45),
    SuraEntity(
      arName: "الذَّارِيَات",
      enName: "Adh-Dhariyat",
      id: 51,
      versesCount: 60,
    ),
    SuraEntity(arName: "الطُّور", enName: "At-Tur", id: 52, versesCount: 49),
    SuraEntity(arName: "النَّجْم", enName: "An-Najm", id: 53, versesCount: 62),
    SuraEntity(arName: "القَمَر", enName: "Al-Qamar", id: 54, versesCount: 55),
    SuraEntity(
      arName: "الرَّحْمَٰن",
      enName: "Ar-Rahman",
      id: 55,
      versesCount: 78,
    ),
    SuraEntity(
      arName: "الوَاقِعَة",
      enName: "Al-Waqi'ah",
      id: 56,
      versesCount: 96,
    ),
    SuraEntity(
      arName: "الْحَدِيد",
      enName: "Al-Hadid",
      id: 57,
      versesCount: 29,
    ),
    SuraEntity(
      arName: "المُجَادِلَة",
      enName: "Al-Mujadilah",
      id: 58,
      versesCount: 22,
    ),
    SuraEntity(arName: "الحَشْر", enName: "Al-Hashr", id: 59, versesCount: 24),
    SuraEntity(
      arName: "المُمَتَّنَة",
      enName: "Al-Mumtahanah",
      id: 60,
      versesCount: 13,
    ),
    SuraEntity(arName: "الصَّف", enName: "As-Saff", id: 61, versesCount: 14),
    SuraEntity(
      arName: "الجُمُعَة",
      enName: "Al-Jumu'ah",
      id: 62,
      versesCount: 11,
    ),
    SuraEntity(
      arName: "المُنَافِقُون",
      enName: "Al-Munafiqun",
      id: 63,
      versesCount: 11,
    ),
    SuraEntity(
      arName: "التَّغَابُن",
      enName: "At-Taghabun",
      id: 64,
      versesCount: 18,
    ),
    SuraEntity(
      arName: "الطَّلَاق",
      enName: "At-Talaq",
      id: 65,
      versesCount: 12,
    ),
    SuraEntity(
      arName: "التحْرِيم",
      enName: "At-Tahrim",
      id: 66,
      versesCount: 12,
    ),
    SuraEntity(arName: "المُلْك", enName: "Al-Mulk", id: 67, versesCount: 30),
    SuraEntity(arName: "القَلَم", enName: "Al-Qalam", id: 68, versesCount: 52),
    SuraEntity(
      arName: "الْحَاقَّة",
      enName: "Al-Haqqah",
      id: 69,
      versesCount: 52,
    ),
    SuraEntity(
      arName: "المَعَارِج",
      enName: "Al-Ma'arij",
      id: 70,
      versesCount: 44,
    ),
    SuraEntity(arName: "نُوح", enName: "Nuh", id: 71, versesCount: 28),
    SuraEntity(arName: "الْجِنّ", enName: "Al-Jinn", id: 72, versesCount: 28),
    SuraEntity(
      arName: "المُزَّمِّل",
      enName: "Al-Muzzammil",
      id: 73,
      versesCount: 20,
    ),
    SuraEntity(
      arName: "الْمُدَّثِّر",
      enName: "Al-Muddathir",
      id: 74,
      versesCount: 56,
    ),
    SuraEntity(
      arName: "القِيَامَة",
      enName: "Al-Qiyamah",
      id: 75,
      versesCount: 40,
    ),
    SuraEntity(
      arName: "الْإِنْسَان",
      enName: "Al-Insan",
      id: 76,
      versesCount: 31,
    ),
    SuraEntity(
      arName: "الْمُرْسَلات",
      enName: "Al-Mursalat",
      id: 77,
      versesCount: 50,
    ),
    SuraEntity(arName: "النَّبَأ", enName: "An-Naba", id: 78, versesCount: 40),
    SuraEntity(
      arName: "النَّازِعَات",
      enName: "An-Nazi'at",
      id: 79,
      versesCount: 46,
    ),
    SuraEntity(arName: "عَبَس", enName: "Abasa", id: 80, versesCount: 42),
    SuraEntity(
      arName: "التَّكْوِير",
      enName: "At-Takwir",
      id: 81,
      versesCount: 29,
    ),
    SuraEntity(
      arName: "الْاِنِفْطَار",
      enName: "Al-Infitar",
      id: 82,
      versesCount: 19,
    ),
    SuraEntity(
      arName: "المُطَفِّفُون",
      enName: "Al-Mutaffifin",
      id: 83,
      versesCount: 36,
    ),
    SuraEntity(
      arName: "الْاِنْشِقَاق",
      enName: "Al-Inshiqaq",
      id: 84,
      versesCount: 25,
    ),
    SuraEntity(arName: "البُرُوج", enName: "Al-Buruj", id: 85, versesCount: 22),
    SuraEntity(
      arName: "الطَّارِق",
      enName: "At-Tariq",
      id: 86,
      versesCount: 17,
    ),
    SuraEntity(arName: "الأَعْلَى", enName: "Al-A'la", id: 87, versesCount: 19),
    SuraEntity(
      arName: "الغَاشِيَة",
      enName: "Al-Ghashiyah",
      id: 88,
      versesCount: 26,
    ),
    SuraEntity(arName: "الفَجْر", enName: "Al-Fajr", id: 89, versesCount: 30),
    SuraEntity(arName: "الْبَلَد", enName: "Al-Balad", id: 90, versesCount: 20),
    SuraEntity(
      arName: "الشَّمْس",
      enName: "Ash-Shams",
      id: 91,
      versesCount: 15,
    ),
    SuraEntity(arName: "اللَّيْل", enName: "Al-Layl", id: 92, versesCount: 21),
    SuraEntity(arName: "الضُّحَى", enName: "Ad-Dhuha", id: 93, versesCount: 11),
    SuraEntity(arName: "الشَّرْح", enName: "Ash-Sharh", id: 94, versesCount: 8),
    SuraEntity(arName: "التِّيْن", enName: "At-Tin", id: 95, versesCount: 8),
    SuraEntity(arName: "الْعَلَق", enName: "Al-Alaq", id: 96, versesCount: 19),
    SuraEntity(arName: "الْقَدْر", enName: "Al-Qadr", id: 97, versesCount: 5),
    SuraEntity(
      arName: "الْبَيِّنَة",
      enName: "Al-Bayyinah",
      id: 98,
      versesCount: 8,
    ),
    SuraEntity(
      arName: "الزَّلْزَلَة",
      enName: "Az-Zalzalah",
      id: 99,
      versesCount: 8,
    ),
    SuraEntity(
      arName: "الْعَادِيَات",
      enName: "Al-Adiyat",
      id: 100,
      versesCount: 11,
    ),
    SuraEntity(
      arName: "الْقَارِعَة",
      enName: "Al-Qari'ah",
      id: 101,
      versesCount: 11,
    ),
    SuraEntity(
      arName: "التَّكَاثُر",
      enName: "At-Takathur",
      id: 102,
      versesCount: 8,
    ),
    SuraEntity(arName: "العَصْر", enName: "Al-Asr", id: 103, versesCount: 3),
    SuraEntity(
      arName: "الهُمَزَة",
      enName: "Al-Humazah",
      id: 104,
      versesCount: 9,
    ),
    SuraEntity(arName: "الفِيل", enName: "Al-Fil", id: 105, versesCount: 5),
    SuraEntity(arName: "قُرَيْش", enName: "Quraysh", id: 106, versesCount: 4),
    SuraEntity(
      arName: "الْمَاعُون",
      enName: "Al-Ma'un",
      id: 107,
      versesCount: 7,
    ),
    SuraEntity(
      arName: "الْكَوْثَر",
      enName: "Al-Kawthar",
      id: 108,
      versesCount: 3,
    ),
    SuraEntity(
      arName: "الْكَافِرُونَ",
      enName: "Al-Kafirun",
      id: 109,
      versesCount: 6,
    ),
    SuraEntity(arName: "النَّصْر", enName: "An-Nasr", id: 110, versesCount: 3),
    SuraEntity(arName: "الْمَسَد", enName: "Al-Masad", id: 111, versesCount: 5),
    SuraEntity(
      arName: "الإِخْلاَص",
      enName: "Al-Ikhlas",
      id: 112,
      versesCount: 4,
    ),
    SuraEntity(arName: "الفَلَق", enName: "Al-Falaq", id: 113, versesCount: 5),
    SuraEntity(arName: "النَّاس", enName: "An-Nas", id: 114, versesCount: 6),
  ];
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
      final data = await rootBundle.loadString('assets/quran/${sura.id}.txt');
      final verses = data
          .split('\n')
          .where((v) => v.trim().isNotEmpty)
          .toList();
      emit(QuranSuraLoaded(sura: sura, verses: verses));
    } catch (e) {
      emit(QuranSuraError(message: e.toString()));
    }
  }
}

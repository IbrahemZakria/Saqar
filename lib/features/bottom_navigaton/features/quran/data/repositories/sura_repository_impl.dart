import 'package:quran/quran.dart' as quran;
import 'package:atrega/core/utils/quran.dart';
import '../../domain/entities/sura_entity.dart';
import '../../domain/repositories/sura_repository.dart';

class SuraRepositoryImpl implements SuraRepositoryContract {
  @override
  Future<List<SuraEntity>> getAllSuras() async {
    // quranSuras is a simple in-memory list provided by the app
    return quranSuras;
  }

  @override
  Future<List<String>> getSuraText(int suraId) async {
    final totalVerses = quran.getVerseCount(suraId);
    List<String> verses = [];
    for (int i = 1; i <= totalVerses; i++) {
      verses.add(quran.getVerse(suraId, i));
    }
    return verses;
  }
}

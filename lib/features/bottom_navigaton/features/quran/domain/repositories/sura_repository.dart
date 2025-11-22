import '../../domain/entities/sura_entity.dart';

abstract class SuraRepositoryContract {
  Future<List<SuraEntity>> getAllSuras();
  Future<List<String>> getSuraText(int suraId);
}

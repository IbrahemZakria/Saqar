import '../entities/reciter_entity.dart';

abstract class RecitersRepositoryContract {
  Future<List<ReciterEntity>> fetchReciters();
}

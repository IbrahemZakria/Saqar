import 'package:atrega/core/usecase/usecase.dart';
import '../entities/reciter_entity.dart';
import '../repositories/reciters_repository.dart';

class LoadReciters implements UseCase<List<ReciterEntity>, NoParams> {
  final RecitersRepositoryContract repository;
  LoadReciters(this.repository);

  @override
  Future<List<ReciterEntity>> call(NoParams params) async {
    return repository.fetchReciters();
  }
}

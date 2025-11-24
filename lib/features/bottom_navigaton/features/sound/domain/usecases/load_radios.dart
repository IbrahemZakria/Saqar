import 'package:atrega/core/usecase/usecase.dart';
import '../entities/radio_entity.dart';
import '../repositories/radio_repository.dart';

class LoadRadios implements UseCase<List<RadioEntity>, NoParams> {
  final RadioRepositoryContract repository;
  LoadRadios(this.repository);

  @override
  Future<List<RadioEntity>> call(NoParams params) async {
    return repository.fetchRadios();
  }
}

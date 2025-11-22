import 'package:atrega/features/bottom_navigaton/features/ahades/data/datasources/ahades_local_datasource.dart';
import 'package:atrega/features/bottom_navigaton/features/ahades/domain/entities/ahades_entity.dart';
import 'package:atrega/features/bottom_navigaton/features/ahades/domain/repositories/ahades_repository.dart';

class AhadesRepositoryImpl implements AhadesRepository {
  final AhadesLocalDataSource localDataSource;

  AhadesRepositoryImpl({AhadesLocalDataSource? localDataSource})
    : localDataSource = localDataSource ?? AhadesLocalDataSourceImpl();

  @override
  Future<List<AhadesEntity>> getAhadith() async {
    return await localDataSource.loadAhadithFromAssets();
  }
}

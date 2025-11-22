import 'package:atrega/features/bottom_navigaton/features/ahades/domain/entities/ahades_entity.dart';

abstract class AhadesRepository {
  Future<List<AhadesEntity>> getAhadith();
}

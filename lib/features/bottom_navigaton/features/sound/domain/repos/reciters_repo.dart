import 'package:atrega/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';

abstract class RecitersRepository {
  Future<List<ReciterEntity>> getAllReciters();
}

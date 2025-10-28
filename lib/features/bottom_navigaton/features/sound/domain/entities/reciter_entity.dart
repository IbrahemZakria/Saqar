import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/moshaf_entity.dart';

class ReciterEntity {
  final int id;
  final String name;
  final String letter;
  final List<MoshafEntity> moshaf;

  ReciterEntity({
    required this.id,
    required this.name,
    required this.letter,
    required this.moshaf,
  });
}

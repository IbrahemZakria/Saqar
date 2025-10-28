import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/moshaf_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';

class MoshafModel extends MoshafEntity {
  MoshafModel({
    required super.id,
    required super.name,
    required super.server,
    required super.surahList,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    return MoshafModel(
      id: json['id'],
      name: json['name'],
      server: json['server'],
      surahList: json['surah_list'],
    );
  }
}

class ReciterModel extends ReciterEntity {
  ReciterModel({
    required super.id,
    required super.name,
    required super.moshaf,
    required super.letter,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    return ReciterModel(
      id: json['id'],
      name: json['name'],
      moshaf: (json['moshaf'] as List)
          .map((e) => MoshafModel.fromJson(e))
          .toList(),
      letter: '',
    );
  }
}

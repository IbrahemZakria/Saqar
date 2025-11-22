import 'package:flutter/services.dart';
import 'package:atrega/features/bottom_navigaton/features/ahades/domain/entities/ahades_entity.dart';

abstract class AhadesLocalDataSource {
  Future<List<AhadesEntity>> loadAhadithFromAssets();
}

class AhadesLocalDataSourceImpl implements AhadesLocalDataSource {
  final String assetPath;
  AhadesLocalDataSourceImpl({this.assetPath = 'assets/ahades/ahadeth.txt'});

  @override
  Future<List<AhadesEntity>> loadAhadithFromAssets() async {
    final file = await rootBundle.loadString(assetPath);
    final parts = file.split('#').where((e) => e.trim().isNotEmpty).toList();

    final ahadith = parts.map<AhadesEntity>((section) {
      final lines = section.trim().split('\n');
      final title = lines.first.trim();
      final content = lines.skip(1).join('\n').trim();
      return AhadesEntity(title: title, content: content);
    }).toList();

    return ahadith;
  }
}

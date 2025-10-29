import 'package:saqar/features/bottom_navigaton/features/setting/domain/entities/adhkar_entity.dart';

class AdhkarCategoryEntity {
  final String id;
  final String title;
  final String imagePath;
  final List<AdhkarEntity>? azkar; // نقدر نخزن الأذكار هنا

  const AdhkarCategoryEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    this.azkar,
  });
}

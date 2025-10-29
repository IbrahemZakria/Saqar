import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import '../../domain/entities/adhkar_entity.dart';
import '../../domain/entities/adhkar_category_entity.dart';
import 'package:saqar/core/utils/assets.dart';

class AdhkarRepository {
  final _repo = MuslimRepository();

  // جلب الفئات المحلية
  Future<List<AdhkarCategoryEntity>> getLocalCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      AdhkarCategoryEntity(
        id: '1',
        title: 'أذكار الصباح',
        imagePath: Assets.resourceImagesAdhkarMorning,
      ),
      AdhkarCategoryEntity(
        id: '2',
        title: 'أذكار المساء',
        imagePath: Assets.resourceImagesAdhkarEvening,
      ),
      // باقي الفئات ...
    ];
  }

  // جلب الأذكار من MuslimRepository
  Future<List<AdhkarEntity>> getAzkarByCategory(String categoryTitle) async {
    const lang = Language.ar;

    final categories = await _repo.getAzkarCategories(language: lang);
    final matched = categories.firstWhere(
      (c) => c.name.toLowerCase().contains(categoryTitle.toLowerCase()),
      orElse: () => categories.first,
    );

    final chapters = await _repo.getAzkarChapters(
      language: lang,
      categoryId: matched.id,
    );

    List<AdhkarEntity> result = [];
    for (var chap in chapters) {
      final items = await _repo.getAzkarItems(
        language: lang,
        chapterId: chap.id,
      );
      result.addAll(
        items.map((e) => AdhkarEntity(text: e.item, reference: e.reference)),
      );
    }
    return result;
  }

  // جلب الفئات مع الأذكار مباشرة
  Future<List<AdhkarCategoryEntity>> getCategoriesWithAzkar() async {
    final categories = await getLocalCategories();
    List<AdhkarCategoryEntity> result = [];
    for (var cat in categories) {
      final azkar = await getAzkarByCategory(cat.title);
      result.add(
        AdhkarCategoryEntity(
          id: cat.id,
          title: cat.title,
          imagePath: cat.imagePath,
          azkar: azkar,
        ),
      );
    }
    return result;
  }
}

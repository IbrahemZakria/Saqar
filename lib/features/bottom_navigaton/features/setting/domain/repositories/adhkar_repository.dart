import '../entities/adhkar_category_entity.dart';
import '../entities/adhkar_entity.dart';

abstract class AdhkarRepositoryContract {
  Future<List<AdhkarCategoryEntity>> getLocalCategories();
  Future<List<AdhkarEntity>> getAzkarByCategory(String categoryTitle);
  Future<List<AdhkarCategoryEntity>> getCategoriesWithAzkar();
}

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/tasbeeh_repository.dart';

class TasbeehRepositoryImpl implements TasbeehRepository {
  static const _kCountKey = 'tasbeeh_count';

  @override
  Future<int> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kCountKey) ?? 0;
  }

  @override
  Future<void> saveCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCountKey, count);
  }
}

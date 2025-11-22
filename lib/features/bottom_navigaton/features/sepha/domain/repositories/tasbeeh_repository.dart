abstract class TasbeehRepository {
  Future<int> getCount();
  Future<void> saveCount(int count);
}

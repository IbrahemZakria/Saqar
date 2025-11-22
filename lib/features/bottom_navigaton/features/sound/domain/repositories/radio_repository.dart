import '../entities/radio_entity.dart';

abstract class RadioRepositoryContract {
  Future<List<RadioEntity>> fetchRadios();
}

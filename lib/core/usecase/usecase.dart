// Simple UseCase base class for Clean Architecture
abstract class UseCase<R, Params> {
  const UseCase();
  Future<R> call(Params params);
}

// Special class for usecases without params
class NoParams {}

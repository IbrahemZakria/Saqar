part of 'adhkar_cubit.dart';

abstract class AdhkarState {}

class AdhkarInitial extends AdhkarState {}

class AdhkarLoading extends AdhkarState {}

class AdhkarLoaded extends AdhkarState {
  final List<AdhkarCategoryEntity> categories;
  AdhkarLoaded(this.categories);
}

class AdhkarError extends AdhkarState {
  final String message;
  AdhkarError(this.message);
}

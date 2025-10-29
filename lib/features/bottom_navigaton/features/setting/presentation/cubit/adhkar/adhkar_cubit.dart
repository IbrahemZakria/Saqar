import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/data/repositories/adhkar_repository_impel.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/domain/entities/adhkar_category_entity.dart';
part 'adhkar_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  final AdhkarRepository repository;
  AdhkarCubit(this.repository) : super(AdhkarInitial());

  Future<void> loadCategoriesWithAzkar() async {
    emit(AdhkarLoading());
    try {
      final data = await repository.getCategoriesWithAzkar();
      emit(AdhkarLoaded(data));
    } catch (e) {
      emit(AdhkarError(e.toString()));
    }
  }
}

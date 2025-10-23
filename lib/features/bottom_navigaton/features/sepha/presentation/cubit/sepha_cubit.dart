import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sepha_state.dart';

class SephaCubit extends Cubit<SephaState> {
  SephaCubit() : super(SephaInitial());
}

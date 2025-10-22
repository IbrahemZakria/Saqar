import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ahades_state.dart';

class AhadesCubit extends Cubit<AhadesState> {
  AhadesCubit() : super(AhadesInitial());
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SoundTabCubit extends Cubit<int> {
  SoundTabCubit() : super(0); // 0 = الإذاعة, 1 = القراء

  void changeTab(int index) => emit(index);
}

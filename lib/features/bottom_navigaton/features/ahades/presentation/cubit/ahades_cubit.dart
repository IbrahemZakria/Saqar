import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/ahades/presentation/cubit/ahades_state.dart';

class AhadesCubit extends Cubit<AhadesState> {
  AhadesCubit() : super(AhadesState());

  Future<void> loadAhadith() async {
    emit(state.copyWith(isLoading: true));

    try {
      final file = await rootBundle.loadString('assets/ahades/ahadeth.txt');

      final parts = file.split('#').where((e) => e.trim().isNotEmpty).toList();

      final ahadith = parts.map<Map<String, String>>((section) {
        final lines = section.trim().split('\n');
        final title = lines.first.trim();
        final content = lines.skip(1).join('\n').trim();
        return {'title': title, 'content': content};
      }).toList();

      emit(state.copyWith(ahadith: ahadith, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}

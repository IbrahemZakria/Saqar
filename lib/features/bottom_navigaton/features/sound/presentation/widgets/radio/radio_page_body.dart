import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_state.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/radio/radio_item.dart';

class RadioPageBody extends StatelessWidget {
  const RadioPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RadioCubit,
      ({RadioLoadState load, RadioPlayerState player})
    >(
      // إعادة بناء فقط عند تغيير جزء التحميل (load)
      buildWhen: (prev, curr) => prev.load.runtimeType != curr.load.runtimeType,
      builder: (context, state) {
        final load = state.load;

        // حالة التحميل
        if (load is RadioLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // حالة وجود خطأ
        if (load is RadioError) {
          return Center(
            child: Text(
              "حدث خطأ أثناء تحميل الإذاعات",
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        // حالة التحميل الناجح
        if (load is RadioLoaded) {
          final radios = load.radios;
          if (radios.isEmpty) {
            return const Center(child: Text('لا توجد إذاعات متاحة حاليًا'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: radios.length,
            itemBuilder: (context, index) {
              final radio = radios[index];
              return RadioItem(radio: radio);
            },
          );
        }

        // الحالة الابتدائية أو أي حالة غير متوقعة
        return Center(
          child: ElevatedButton(
            onPressed: () => context.read<RadioCubit>().fetchRadios(),
            child: const Text('تحميل الإذاعات'),
          ),
        );
      },
    );
  }
}

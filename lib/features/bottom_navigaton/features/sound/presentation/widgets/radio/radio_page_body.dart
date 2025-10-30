import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_state.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/radio/radio_item.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_error.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_item_loading.dart';

class RadioPageBody extends StatelessWidget {
  const RadioPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RadioCubit,
      ({RadioLoadState load, RadioPlayerState player})
    >(
      buildWhen: (prev, curr) => prev.load.runtimeType != curr.load.runtimeType,
      builder: (context, state) {
        final load = state.load;

        return RefreshIndicator(
          onRefresh: () async {
            await context.read<RadioCubit>().fetchRadios();
          },
          child: Builder(
            builder: (context) {
              // حالة التحميل
              if (load is RadioLoading) {
                return const SoundItemLoading();
              }

              // حالة الخطأ
              if (load is RadioError) {
                SoundError();
              }

              // حالة التحميل الناجح
              if (load is RadioLoaded) {
                final radios = load.radios;
                if (radios.isEmpty) {
                  return ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(
                        child: Card(
                          child: Text(
                            "خطأ في الاتصال، يرجى إعادة المحاولة لاحقًا",
                          ),
                        ),
                      ),
                    ],
                  );
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

              // الحالة الابتدائية
              return SoundError();
            },
          ),
        );
      },
    );
  }
}

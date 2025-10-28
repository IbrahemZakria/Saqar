import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/radio/radio_state.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_item.dart';
import '../../../domain/entities/radio_entity.dart';

class RadioItem extends StatelessWidget {
  final RadioEntity radio;
  const RadioItem({super.key, required this.radio});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RadioCubit,
      ({RadioLoadState load, RadioPlayerState player})
    >(
      buildWhen: (prev, curr) =>
          prev.player.isPlaying != curr.player.isPlaying ||
          prev.player.currentRadio != curr.player.currentRadio,
      builder: (context, state) {
        final cubit = context.read<RadioCubit>();
        final isCurrent = state.player.currentRadio?.id == radio.id;
        final isPlaying = state.player.isPlaying && isCurrent;

        return SoundItem(
          isPlaying: isPlaying,
          name: radio.name,
          onpresed: () {
            cubit.playRadio(radio);
          },
        );
      },
    );
  }
}

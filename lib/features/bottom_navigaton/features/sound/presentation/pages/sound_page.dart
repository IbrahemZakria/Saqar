import 'package:flutter/material.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_page_body.dart';
import 'package:saqar/features/bottom_navigaton/widgets/taps_background.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});
  static final String routeName = "/SoundPage";

  @override
  Widget build(BuildContext context) {
    return TapsBackground(
      image: Assets.resourceImagesRadioBackground,
      widget: SoundPageBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:atrega/core/utils/assets.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/widgets/quran_body.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/widgets/search_text_form_field.dart';
import 'package:atrega/features/bottom_navigaton/widgets/taps_background.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});
  static final String routeName = "/QuranPage";

  @override
  Widget build(BuildContext context) {
    return TapsBackground(
      widget: Column(children: [SearchTextFormField(), QuranBody()]),
      image: Assets.resourceImagesBackgroundQuran,
    );
  }
}

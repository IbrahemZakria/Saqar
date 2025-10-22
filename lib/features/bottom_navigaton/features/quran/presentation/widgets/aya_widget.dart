import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_icon.dart';

class AyaWidget extends StatelessWidget {
  const AyaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AyaIcon(ayaNumper: 1),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                "Elfateha",
                style: AppTextSyles.textStyle20b(context),
              ),
            ),
            FittedBox(
              child: Text(
                "17 views",
                style: AppTextSyles.textStyle14b(context),
              ),
            ),
          ],
        ),
        Spacer(),
        FittedBox(
          child: Text("Elfateha", style: AppTextSyles.textStyle20b(context)),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';

class AyaIcon extends StatelessWidget {
  const AyaIcon({super.key, required this.ayaNumper});
  final int ayaNumper;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(Assets.resourceImagesAya, width: 40),
        Text(
          ayaNumper.toString(),
          textAlign: TextAlign.center,
          style: ayaNumper < 10
              ? AppTextSyles.textStyle20b(context)
              : AppTextSyles.textStyle20b(context).copyWith(fontSize: 10),
        ),
      ],
    );
  }
}

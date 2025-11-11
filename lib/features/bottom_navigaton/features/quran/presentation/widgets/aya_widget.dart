import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atrega/core/helper/thems/app_text_syles.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';

class AyaWidget extends StatelessWidget {
  const AyaWidget({super.key, required this.suraEntity});

  final SuraEntity suraEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed('surah', extra: suraEntity);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  suraEntity.enName,
                  style: AppTextSyles.textStyle20b(context),
                ),
              ),
              FittedBox(
                child: Text(
                  "${suraEntity.versesCount} views",
                  style: AppTextSyles.textStyle14b(context),
                ),
              ),
            ],
          ),
          Spacer(),
          FittedBox(
            child: Text(
              textAlign: TextAlign.right,
              suraEntity.arName,
              style: AppTextSyles.textStyle20b(context),
            ),
          ),
        ],
      ),
    );
  }
}

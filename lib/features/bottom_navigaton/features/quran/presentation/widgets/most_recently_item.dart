import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';

class MostRecentlyItem extends StatelessWidget {
  const MostRecentlyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.8, // 👈 العرض = ضعف الارتفاع
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.kprimarycolor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ النصوص على اليسار
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FittedBox(
                      child: Text(
                        "Alanbia",
                        style: AppTextSyles.textStyle24re(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Alanbia",
                        style: AppTextSyles.textStyle24re(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "132 view",
                        style: AppTextSyles.textStyle16se(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ الصورة على اليمين بمرونة
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1, // 👈 تحافظ على نسبة مربعة
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.resourceImagesMoshaf,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

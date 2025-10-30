import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayWidgetLoading extends StatelessWidget {
  const PrayWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColors.kprimarycolor, // اللون الأساسي
        highlightColor: Colors.white, // لون اللمعة
        duration: Duration(seconds: 2), // سرعة الحركة
      ),
      containersColor: AppColors.kprimarycolor.withAlpha(
        200,
      ), // خفيف عشان اللمعة تبان
      enabled: true,
      enableSwitchAnimation: true,
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kprimarycolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,

                      "miladDate.toString()",
                      style: AppTextSyles.textStyle16se(
                        context,
                      ).copyWith(color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Pray Time\n\n",
                      style: AppTextSyles.textStyle16se(
                        context,
                      ).copyWith(color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,

                      "formattedHijri.toString()",
                      style: AppTextSyles.textStyle16se(
                        context,
                      ).copyWith(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: height * .15,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: .4,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "remaining",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  ' - الصلاه القادمه',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

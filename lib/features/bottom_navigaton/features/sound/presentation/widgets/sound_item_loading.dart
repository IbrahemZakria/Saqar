import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SoundItemLoading extends StatelessWidget {
  const SoundItemLoading({super.key});

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
      child: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            height: height * 0.2,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(height: height * .02),
                Flexible(
                  child: Text("datadwwwwwwwww", style: TextStyle(height: 2)),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.insert_chart_outlined_sharp, size: 35)],
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

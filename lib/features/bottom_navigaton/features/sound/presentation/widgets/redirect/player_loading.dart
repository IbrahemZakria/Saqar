import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlayerLoading extends StatelessWidget {
  const PlayerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColors.kprimarycolor, // اللون الأساسي
        highlightColor: Colors.white, // لون اللمعة
        duration: Duration(seconds: 2), // سرعة الحركة
      ),
      containersColor: AppColors.kprimarycolor.withAlpha(200),
      enabled: true,
      enableSwitchAnimation: true,
      child: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Item number $index as title'),
              subtitle: const Text('Subtitle here'),
              trailing: const Icon(Icons.ac_unit, size: 32),
            ),
          );
        },
      ),
    );
  }
}

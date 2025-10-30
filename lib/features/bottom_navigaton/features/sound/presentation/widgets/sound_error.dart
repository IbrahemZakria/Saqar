import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';

class SoundError extends StatelessWidget {
  const SoundError({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Card(
          color: AppColors.kprimarycolor,
          child: const ListTile(
            title: Text(
              "حدث خطأ أثناء التحميل ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

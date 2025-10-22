import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/domain/entities/bottom_app_bar_entity.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({super.key, required this.bottomAppBarEntity});
  final BottomAppBarEntity bottomAppBarEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kopacityBlackColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.kopacityBlackColor,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(bottomAppBarEntity.selectedImage),
              ),
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              bottomAppBarEntity.title,
              style: AppTextSyles.textStyle11se(context),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}

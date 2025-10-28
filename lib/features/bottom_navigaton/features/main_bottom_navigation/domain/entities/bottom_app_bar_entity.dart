import 'package:flutter/material.dart';
import 'package:saqar/core/utils/assets.dart';

class BottomAppBarEntity {
  final String title, selectedImage, unSelectedImage;
  final int index;

  BottomAppBarEntity(
    this.title,
    this.selectedImage,
    this.unSelectedImage,
    this.index,
  );

  static List<BottomAppBarEntity> getBottomAppBarItems(BuildContext context) {
    final items = [
      BottomAppBarEntity(
        "القرءان",
        Assets.resourceImagesSelectedQuranIcon,
        Assets.resourceImagesUnSelectedQuranIcon,
        0,
      ),
      BottomAppBarEntity(
        "الاحاديث",
        Assets.resourceImagesSelectedHadesIcon,
        Assets.resourceImagesUnSelectedAhadesIcon,
        1,
      ),
      BottomAppBarEntity(
        "سبح",
        Assets.resourceImagesSelectedSephaIcon,
        Assets.resourceImagesUnSelectedSephaIcon,
        2,
      ),
      BottomAppBarEntity(
        "استمع",
        Assets.resourceImagesSelectedRadioIcon,

        Assets.resourceImagesUnSelectedRadioIcon,
        3,
      ),
      BottomAppBarEntity(
        "الاعدادات",
        Assets.resourceImagesSelectedTimeIcon,
        Assets.resourceImagesUnSelectedTimeIcon,
        4,
      ),
    ];
    return items;
  }
}

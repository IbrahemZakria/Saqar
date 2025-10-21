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
        "Quran",
        Assets.resourceImagesSelectedQuranIcon,
        Assets.resourceImagesUnSelectedQuranIcon,
        0,
      ),
      BottomAppBarEntity(
        "Hades",
        Assets.resourceImagesSelectedHadesIcon,
        Assets.resourceImagesUnSelectedAhadesIcon,
        1,
      ),
      BottomAppBarEntity(
        "Taspeh",
        Assets.resourceImagesSelectedSephaIcon,
        Assets.resourceImagesUnSelectedSephaIcon,
        2,
      ),
      BottomAppBarEntity(
        "Radio",
        Assets.resourceImagesSelectedRadioIcon,

        Assets.resourceImagesUnSelectedRadioIcon,
        3,
      ),
      BottomAppBarEntity(
        "Time",
        Assets.resourceImagesSelectedTimeIcon,
        Assets.resourceImagesUnSelectedTimeIcon,
        4,
      ),
    ];
    return items;
  }
}

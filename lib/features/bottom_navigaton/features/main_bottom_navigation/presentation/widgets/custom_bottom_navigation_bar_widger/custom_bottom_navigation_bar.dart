import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/domain/entities/bottom_app_bar_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/widgets/custom_bottom_navigation_bar_widger/navigation_bottom_app_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedItem,
    required this.selectedIndex,
  });

  final ValueChanged<int> selectedItem;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.kprimarycolor,

      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: BottomAppBarEntity.getBottomAppBarItems(context)
            .asMap()
            .entries
            .map((entry) {
              int index = entry.key;
              var item = entry.value;

              return Expanded(
                flex: index == selectedIndex ? 3 : 2,
                child: GestureDetector(
                  onTap: () {
                    selectedItem(index);
                  },
                  child: NavigationBottomAppBarItem(
                    isselected: selectedIndex == index,
                    bottomAppBarEntity: item,
                  ),
                ),
              );
            })
            .toList(),
      ),
    );
  }
}

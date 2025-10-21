import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/domain/entities/bottom_app_bar_entity.dart';

class UnSelectedItem extends StatelessWidget {
  final BottomAppBarEntity bottomAppBarEntity;

  const UnSelectedItem({super.key, required this.bottomAppBarEntity});

  @override
  Widget build(BuildContext context) {
    // عدد المنتجات في الكارت مباشرة من الـ Cubit

    Widget iconWidget = SvgPicture.asset(bottomAppBarEntity.unSelectedImage);

    return Container(color: Colors.transparent, child: iconWidget);
  }
}

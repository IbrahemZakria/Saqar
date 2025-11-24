import 'package:flutter/material.dart';
import 'package:atrega/core/utils/assets.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/widgets/setting_body.dart';
import 'package:atrega/features/bottom_navigaton/widgets/taps_background.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static final String routeName = "/SettingPage";

  @override
  Widget build(BuildContext context) {
    return TapsBackground(
      notificationVisale: true,
      widget: SettingBody(),
      image: Assets.resourceImagesTimeBackground,
    );
  }
}

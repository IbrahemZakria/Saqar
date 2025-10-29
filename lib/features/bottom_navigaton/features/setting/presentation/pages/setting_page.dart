import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/setting_body.dart';
import 'package:saqar/features/bottom_navigaton/widgets/taps_background.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static final String routeName = "/SettingPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerCubit(),
      child: TapsBackground(
        widget: SettingBody(),
        image: Assets.resourceImagesTimeBackground,
      ),
    );
  }
}

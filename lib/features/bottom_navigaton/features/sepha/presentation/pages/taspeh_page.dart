import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sepha/presentation/widgets/taspesh_body.dart';
import 'package:saqar/features/bottom_navigaton/widgets/taps_background.dart';

class TaspehPage extends StatelessWidget {
  const TaspehPage({super.key});
  static final String routeName = "/TaspehPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbeehCubit(),
      child: TapsBackground(
        widget: TaspeshBody(),
        image: Assets.resourceImagesSebhaBackground,
      ),
    );
  }
}

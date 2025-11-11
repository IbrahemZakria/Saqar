import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atrega/core/utils/assets.dart';
import 'package:atrega/features/bottom_navigaton/features/ahades/presentation/cubit/ahades_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/ahades/presentation/widgets/ahades_body.dart';
import 'package:atrega/features/bottom_navigaton/widgets/taps_background.dart';

class AhadesPage extends StatelessWidget {
  const AhadesPage({super.key});
  static final String routeName = "/AhadesPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AhadesCubit()..loadAhadith(),
      child: TapsBackground(
        image: Assets.resourceImagesHadethBackground,
        widget: AhadesBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_state.dart';

class TaspeshBody extends StatefulWidget {
  const TaspeshBody({super.key});

  @override
  State<TaspeshBody> createState() => _TaspeshBodyState();
}

class _TaspeshBodyState extends State<TaspeshBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, state) {
        final cubit = context.read<TasbeehCubit>();

        _controller.forward(from: 0);

        return SizedBox.expand(
          child: Stack(
            children: [
              Positioned(
                top: height * .05,
                right: 0,
                left: 0,
                child: Text(
                  "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
                  textAlign: TextAlign.center,
                  style: AppTextSyles.textStyle36b(context),
                ),
              ),
              Positioned(
                bottom: height * .51,
                right: width * .3,
                child: Image.asset(
                  Assets.resourceImagesSephaHeader,
                  width: width * .15,
                ),
              ),
              Positioned(
                bottom: height * .2,
                right: width * .1,
                child: GestureDetector(
                  onTap: () => cubit.onTap(),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(angle: state.angle, child: child);
                    },
                    child: Image.asset(
                      Assets.resourceImagesSebhaBody,
                      width: width * .7,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height * .32,
                right: width * .2,
                left: width * .2,
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        cubit.currentZikr,
                        textAlign: TextAlign.center,
                        style: AppTextSyles.textStyle36b(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Text(
                        "عدد التسبيح: ${state.count}",
                        textAlign: TextAlign.center,
                        style: AppTextSyles.textStyle24re(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

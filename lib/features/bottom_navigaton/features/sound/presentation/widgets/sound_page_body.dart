import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/sound/sound_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/radio/radio_page_body.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/redirect/reciter_page_body.dart';

class SoundPageBody extends StatelessWidget {
  const SoundPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SoundTabCubit(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          BlocBuilder<SoundTabCubit, int>(
            builder: (context, selectedIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton(
                    context,
                    index: 0,
                    label: "الإذاعة",
                    isSelected: selectedIndex == 0,
                  ),
                  _buildTabButton(
                    context,
                    index: 1,
                    label: "القرّاء",
                    isSelected: selectedIndex == 1,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<SoundTabCubit, int>(
              builder: (context, selectedIndex) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: selectedIndex == 0
                      ? const RadioPageBody()
                      : const ReciterPageBody(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<SoundTabCubit>().changeTab(index),
      child: AnimatedContainer(
        width: MediaQuery.sizeOf(context).width * .4,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kprimarycolor),
          color: isSelected
              ? AppColors.kprimarycolor
              : AppColors.kopacityBlackColor,
          borderRadius: index == 0
              ? BorderRadius.horizontal(left: Radius.circular(12))
              : BorderRadius.horizontal(right: Radius.circular(12)),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.kprimarycolor.withAlpha(80),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextSyles.textStyle16se(
              context,
            ).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

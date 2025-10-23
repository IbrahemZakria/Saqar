import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saqar/features/bottom_navigaton/features/ahades/presentation/cubit/ahades_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/ahades/presentation/cubit/ahades_state.dart';
import 'package:saqar/features/bottom_navigaton/features/ahades/presentation/widgets/ahades_background.dart';

class AhadesBody extends StatelessWidget {
  const AhadesBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<AhadesCubit, AhadesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: height,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          items: state.ahadith.map((hadith) {
            return AhadesBackground(
              header: hadith['title'] ?? '',
              content: hadith['content'] ?? '',
            );
          }).toList(),
        );
      },
    );
  }
}

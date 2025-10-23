import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saqar/core/helper/widgets/custome_text_form_field.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          final cubit = context.read<QuranCubit>();

          return CustomeTextFormField(
            textColor: Colors.white,

            controller: cubit.searchController,
            hintText: "Sura name",
            onchanged: cubit.searchSuras,
            prefixIcon: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(Assets.resourceImagesQuranIcon),
              ),
            ),
          );
        },
      ),
    );
  }
}

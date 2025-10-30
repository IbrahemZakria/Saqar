import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/utils/quran.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/quran_custom_scrol_view.dart';

class QuranBody extends StatelessWidget {
  const QuranBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          final cubit = context.read<QuranCubit>();

          if (state is QuranInitial || cubit.searchController.text.isEmpty) {
            return QuranCustomScrolView(suras: quranSuras);
          } else if (state is QuranSearchState) {
            return state.suras.isNotEmpty
                ? QuranCustomScrolView(suras: state.suras)
                : SizedBox(
                    child: Text(
                      "لو سمحت ادخل قيمه صحيحه",
                      style: AppTextSyles.textStyle20b(context),
                    ),
                  );
          }
          return const SizedBox.shrink(child: Text("لو سمحت ادخل قيمه صحيحه"));
        },
      ),
    );
  }
}

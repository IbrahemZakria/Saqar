import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saqar/constant.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/helper/widgets/custome_text_form_field.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/quran_custom_scrol_view.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});
  static final String routeName = "/QuranPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.resourceImagesBackgroundQuran),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 32,
              left: 32,
              top: 16,
              child: Image.asset(
                width: MediaQuery.sizeOf(context).width,
                Assets.resourceImagesMosque,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  Constant.appName,
                  style: AppTextSyles.textStyle80se(context),
                ),
                Padding(
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
                            child: SvgPicture.asset(
                              Assets.resourceImagesQuranIcon,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<QuranCubit, QuranState>(
                    builder: (context, state) {
                      final cubit = context.read<QuranCubit>();

                      if (state is QuranInitial ||
                          cubit.searchController.text.isEmpty) {
                        return QuranCustomScrolView(suras: cubit.quranSuras);
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
                      return const SizedBox.shrink(
                        child: Text("لو سمحت ادخل قيمه صحيحه"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

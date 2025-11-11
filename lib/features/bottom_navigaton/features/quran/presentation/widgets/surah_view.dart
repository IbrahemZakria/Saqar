import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;
import 'package:atrega/core/helper/thems/app_colors.dart';
import 'package:atrega/core/helper/thems/app_text_syles.dart';
import 'package:atrega/core/utils/assets.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_state.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahView extends StatelessWidget {
  final SuraEntity suraEntity;
  static const String routeName = 'surah';

  const SurahView({super.key, required this.suraEntity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuranCubit>();
    cubit.loadSuraText(suraEntity);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ===== عنوان السورة =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.resourceImagesImgLeftCorner),
                Text(
                  suraEntity.arName,
                  style: AppTextSyles.textStyle24re(
                    context,
                  ).copyWith(color: AppColors.kprimarycolor),
                ),
                Image.asset(Assets.resourceImagesImgRightCorner),
              ],
            ),

            Expanded(
              child: BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  if (state is QuranLoadingSura) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuranSuraLoaded &&
                      state.sura.id == suraEntity.id) {
                    final verses = state.verses;

                    return ListView.builder(
                      itemCount: 1, // فقرة واحدة فقط لكل السورة
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: SelectableText.rich(
                            TextSpan(
                              style: GoogleFonts.amiri(
                                fontSize: 22,
                                height: 2,
                                color: AppColors.kprimarycolor,
                              ),
                              children: [
                                for (int i = 0; i < verses.length; i++) ...[
                                  TextSpan(text: '${verses[i].trim()} '),
                                  TextSpan(
                                    text: quran.getVerseEndSymbol(
                                      i + 1,
                                      arabicNumeral: true,
                                    ),
                                    style: GoogleFonts.amiri(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const TextSpan(text: ' '),
                                ],
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        );
                      },
                    );
                  } else if (state is QuranSuraError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

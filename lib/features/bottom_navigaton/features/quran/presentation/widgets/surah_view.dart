import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_icon.dart';

class SurahView extends StatelessWidget {
  final SuraEntity suraEntity;
  static final String routeName = 'surah';

  const SurahView({super.key, required this.suraEntity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuranCubit>();
    cubit.loadSuraText(suraEntity); // قراءة نص السورة من الملفات

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                    final verses = state.verses; // قائمة الآيات
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                style: AppTextSyles.textStyle20b(context)
                                    .copyWith(
                                      color: AppColors.kprimarycolor,
                                      height: 2,
                                    ),
                                children: [
                                  for (int i = 0; i < verses.length; i++) ...[
                                    // هنا نشيل المسافات من أول وآخر الآية
                                    TextSpan(text: '${verses[i].trim()} '),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: AyaIcon(ayaNumper: i + 1),
                                    ),
                                    const TextSpan(text: ' '),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/utils/quran.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_state.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_error.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_item.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_item_loading.dart';

class SurahListPage extends StatelessWidget {
  final ReciterEntity reciter;

  const SurahListPage({super.key, required this.reciter});

  @override
  Widget build(BuildContext context) {
    final moshaf = reciter.moshaf.first;
    final surahNumbers = moshaf.surahList.split(',');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.kprimarycolor),
        backgroundColor: Colors.transparent,
        title: Text(
          "الشيخ ${reciter.name}",
          style: AppTextSyles.textStyle24re(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ReciterCubit>().fetchReciters();
        },
        child:
            BlocBuilder<
              ReciterCubit,
              ({ReciterLoadState load, ReciterPlayerState player})
            >(
              builder: (context, state) {
                final load = state.load;

                // حالة التحميل
                if (load is ReciterLoading) {
                  return const SoundItemLoading();
                }

                // حالة الخطأ
                if (load is ReciterError) {
                  return SoundError();
                }

                // حالة التحميل الناجح
                if (load is ReciterLoaded) {
                  final playerState = state.player;
                  int? currentPlayingId;
                  bool isPlaying = false;
                  Duration duration = Duration.zero;
                  Duration position = Duration.zero;

                  if (playerState is ReciterPlayerPlaying &&
                      playerState.currentReciter?.id == reciter.id) {
                    currentPlayingId = playerState.currentSuraId;
                    isPlaying = true;
                    duration = playerState.duration;
                    position = playerState.position;
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: surahNumbers.length,
                    itemBuilder: (context, index) {
                      final surahId = int.parse(surahNumbers[index]);
                      final paddedId = surahId.toString().padLeft(3, '0');
                      final url = '${moshaf.server}$paddedId.mp3';
                      final isCurrent = surahId == currentPlayingId;

                      final surahName = quranSuras
                          .firstWhere(
                            (s) => s.id == surahId,
                            orElse: () => SuraEntity(
                              arName: "سورة غير معروفة",
                              enName: "Unknown",
                              id: surahId,
                              versesCount: 0,
                            ),
                          )
                          .arName;

                      return SoundItem(
                        isPlaying: isCurrent && isPlaying,
                        name: surahName,
                        onForward: () =>
                            context.read<ReciterCubit>().forward5Seconds(),
                        onRewind: () =>
                            context.read<ReciterCubit>().rewind5Seconds(),
                        onSeek: (pos) =>
                            context.read<ReciterCubit>().seekTo(pos),
                        duration: isCurrent ? duration : Duration.zero,
                        position: isCurrent ? position : Duration.zero,
                        showControls: isCurrent && isPlaying,
                        onpresed: () {
                          if (isCurrent && isPlaying) {
                            context.read<ReciterCubit>().pauseSound();
                          } else {
                            context.read<ReciterCubit>().playSound(
                              url: url,
                              reciter: reciter,
                              surahId: surahId,
                            );
                          }
                        },
                      );
                    },
                  );
                }

                // الحالة الافتراضية
                return const Center(child: CircularProgressIndicator());
              },
            ),
      ),
    );
  }
}

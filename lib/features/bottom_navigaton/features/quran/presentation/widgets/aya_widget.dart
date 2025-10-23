import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/audio_manger.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_player/quran_player_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_icon.dart';

class AyaWidget extends StatefulWidget {
  const AyaWidget({super.key, required this.suraEntity});

  final SuraEntity suraEntity;

  @override
  State<AyaWidget> createState() => _AyaWidgetState();
}

class _AyaWidgetState extends State<AyaWidget> {
  late QuranPlayerCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<QuranPlayerCubit>(); // حفظ المرجع هنا
  }

  @override
  void dispose() {
    cubit.pause(); // الآن آمن لأننا حفظنا المرجع
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed('surah', extra: widget.suraEntity);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AyaIcon(ayaNumper: widget.suraEntity.versesCount),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  widget.suraEntity.enName,
                  style: AppTextSyles.textStyle20b(context),
                ),
              ),
              FittedBox(
                child: Text(
                  "${widget.suraEntity.versesCount} views",
                  style: AppTextSyles.textStyle14b(context),
                ),
              ),
            ],
          ),
          Spacer(flex: 4),
          FittedBox(
            child: Text(
              textAlign: TextAlign.right,
              widget.suraEntity.arName,
              style: AppTextSyles.textStyle20b(context),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                final cubit = context.read<QuranPlayerCubit>();
                final audioManager = context.read<AudioManager>();

                // يوقف أي صوت آخر
                audioManager.setCurrent(cubit);

                if (cubit.state is QuranPlayerPlaying) {
                  cubit.pause();
                } else if (cubit.state is QuranPlayerPaused) {
                  cubit.resume();
                } else {
                  cubit.playByNumber(widget.suraEntity.id.toString());
                }
              },
              icon: BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
                builder: (context, state) {
                  if (state is QuranPlayerPlaying) {
                    return Icon(Icons.pause_rounded, color: Colors.white);
                  }
                  return Icon(Icons.play_arrow_rounded, color: Colors.white);
                },
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/cubit/redirect/reciter_state.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/redirect/player_loading.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/redirect/surah_list_page.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_error.dart';

class ReciterPageBody extends StatelessWidget {
  const ReciterPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ReciterCubit>().fetchReciters();
      },
      child:
          BlocBuilder<
            ReciterCubit,
            ({ReciterLoadState load, ReciterPlayerState player})
          >(
            builder: (context, state) {
              final loadState = state.load;

              if (loadState is ReciterLoading) {
                return PlayerLoading();
              } else if (loadState is ReciterLoaded) {
                final reciters = loadState.reciters;

                return ListView.builder(
                  itemCount: reciters.length,
                  itemBuilder: (context, index) {
                    final reciter = reciters[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<ReciterCubit>(),
                              child: SurahListPage(reciter: reciter),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          left: 12,
                          right: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kprimarycolor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                "القارئ الشيخ : ${reciter.name}",
                                style: AppTextSyles.textStyle20b(
                                  context,
                                ).copyWith(color: Colors.white70),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (loadState is ReciterError) {
                return SoundError();
              } else {
                return Center(
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<ReciterCubit>().fetchReciters(),
                    child: const Text('تحميل القرّاء'),
                  ),
                );
              }
            },
          ),
    );
  }
}

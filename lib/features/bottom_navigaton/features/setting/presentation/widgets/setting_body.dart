import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/data/repositories/adhkar_repository_impel.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/adhkar/adhkar_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/pray/pray_state.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/adhkar_widget.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/pray_widget.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/pray_widget_loading.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/presentation/widgets/sound_error.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});
  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  DateTime _now = DateTime.now();
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    context.read<PrayerCubit>().fetchPrayerTimes();

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<PrayerCubit>().fetchPrayerTimes(),
      child: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return PrayWidgetLoading();
          }
          if (state is PrayerError) {
            return SoundError();
          }
          if (state is PrayerLoaded) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: PrayWidget(
                    now: _now,
                    todayPrayerTimes: state.todayPrayerTimes,
                    tomorrowPrayerTimes: state.tomorrowPrayerTimes,
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocProvider(
                    create: (_) =>
                        AdhkarCubit(AdhkarRepository())
                          ..loadCategoriesWithAzkar(),
                    child: const AdhkarWidget(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

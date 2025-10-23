import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/widgets/custom_bottom_navigation_bar_widger/custom_bottom_navigation_bar.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/audio_manger.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QuranCubit()),
        BlocProvider(create: (_) => BottomNavCubit()),
        Provider<AudioManager>(create: (_) => AudioManager()),
      ],
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedItem: (value) {
                // حدّث الـ cubit
                context.read<BottomNavCubit>().changeTab(value);

                // بدّل الـ branch
                navigationShell.goBranch(
                  value,
                  initialLocation: value == navigationShell.currentIndex,
                );
              },
              selectedIndex: currentIndex,
            ),

            body: navigationShell, // ⚡ مهم: نستخدم navigationShell مباشرة
          );
        },
      ),
    );
  }
}

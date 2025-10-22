import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0); // 0 = Quran tab by default

  final List<String> tabs = [
    '/home/quran',
    // '/home/azkar',
    // '/home/settings',
  ];

  void changeTab(BuildContext context, int index) {
    if (index < 0 || index >= tabs.length) return; // حماية 👈
    if (index == state) return;

    emit(index);
    context.go(tabs[index]);
  }
}

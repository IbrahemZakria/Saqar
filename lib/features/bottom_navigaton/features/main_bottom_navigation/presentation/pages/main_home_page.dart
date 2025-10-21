import 'package:flutter/material.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/widgets/custom_bottom_navigation_bar_widger/custom_bottom_navigation_bar.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});
  static final String routeName = "/MainHomePage";

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentIndex = 0;

  void _selectTab(BuildContext context, int value, int oldIndex) {
    setState(() {
      currentIndex = value;
    });

    // هنا تقدر تعمل أي حاجة لما التاب يتغير
    // مثلاً: التنقل لصفحة معينة
    // Navigator.pushNamed(context, routes[value]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedItem: (value) {
          _selectTab(context, value, currentIndex);
        },
        selectedIndex: currentIndex,
      ),
      body: Center(
        child: Text(
          'Current Index: $currentIndex',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

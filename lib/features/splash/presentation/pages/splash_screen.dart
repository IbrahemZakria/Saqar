import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/on_boarding/presentation/pages/main_on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _moveAnimation = Tween<double>(
      begin: 0,
      end:
          -MediaQueryData.fromView(WidgetsBinding.instance.window).size.height *
          0.25,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _controller.forward().then((value) => context.go(MainOnBoarding.routeName));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ الخلفية SVG
          Image.asset(Assets.resourceImagesSplashScreen, fit: BoxFit.cover),

          // ✅ اللوجو المتحرك
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _moveAnimation.value),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Align(
                    alignment: const Alignment(0, 0.5),
                    child: SvgPicture.asset(
                      Assets.resourceImagesIslamiLogo,
                      height: screenHeight * 0.2,
                    ),
                  ),
                ),
              );
            },
          ),
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
        ],
      ),
    );
  }
}

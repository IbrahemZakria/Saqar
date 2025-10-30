import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/on_boarding/presentation/data/models/onboarding_model.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    super.key,
    required this.onboardingModel,
    required this.modelLenth,
    required this.pageController,
  });
  final OnboardingModel onboardingModel;
  final int modelLenth;
  final PageController pageController;

  @override
  State<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _textFadeAnimation1;
  late Animation<double> _textFadeAnimation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // ✅ Fade للصورة
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    // ✅ النص الأول يظهر بعد انتهاء الحركة
    _textFadeAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.9, curve: Curves.easeIn),
      ),
    );

    // ✅ النص الثاني بعده بشوية
    _textFadeAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenHeight = MediaQuery.of(context).size.height;

    _moveAnimation = Tween<double>(
      begin: screenHeight,
      end: -screenHeight * 0.25,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedText(Animation<double> animation, String text, double top) {
    return Positioned(
      right: 32,
      left: 32,
      top: top,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: animation.value,
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextSyles.textStyle20b(
                    context,
                  ).copyWith(color: AppColors.kprimarycolor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ✅ الصورة المتحركة
          AnimatedBuilder(
            animation: _controller,
            child: Image.asset(widget.onboardingModel.img),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _moveAnimation.value),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Align(
                    alignment: const Alignment(0, 0.9),
                    child: child,
                  ),
                ),
              );
            },
          ),

          // ✅ الخلفية العلوية
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

          // ✅ النصوص المتتابعة
          if (widget.onboardingModel.titel != null) ...[
            _animatedText(
              _textFadeAnimation1,
              widget.onboardingModel.titel!,
              screenHeight * 0.7,
            ),
          ],
          _animatedText(
            _textFadeAnimation2,
            widget.onboardingModel.suTitel,
            widget.onboardingModel.titel != null
                ? screenHeight * 0.76
                : screenHeight * 0.6,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:saqar/constant.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';

class TapsBackground extends StatelessWidget {
  const TapsBackground({super.key, this.widget, required this.image});
  final Widget? widget;
  final String image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
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
            Positioned(
              right: 32,
              left: 32,
              top: height * .1,
              child: Text(
                textAlign: TextAlign.center,
                Constant.appName,
                style: AppTextSyles.textStyle80se(context),
              ),
            ),
            if (widget != null) ...[
              Positioned(
                right: 16,
                left: 16,
                top: height * .23,
                bottom: 0,
                child: Container(child: widget),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

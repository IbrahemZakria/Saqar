import 'package:flutter/material.dart';
import 'package:atrega/constant.dart';
import 'package:atrega/core/helper/thems/app_text_syles.dart';
import 'package:atrega/core/helper/widgets/notification_icon.dart';
import 'package:atrega/core/utils/assets.dart';

class TapsBackground extends StatelessWidget {
  const TapsBackground({
    super.key,
    this.widget,
    required this.image,
    this.notificationVisale = false,
  });
  final Widget? widget;
  final bool notificationVisale;
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
              right: 16,
              top: 8,
              child: Visibility(
                visible: notificationVisale,
                child: Text("data"),
                // NotificationIcon(),
              ),
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

import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height = 60,
    this.color = AppColors.kprimarycolor,
    this.textColor = Colors.white,
    this.elevation = 0,
    this.borderRadius = 50,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final double height;
  final Color color;
  final Color textColor;
  final double elevation;
  final double borderRadius;

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

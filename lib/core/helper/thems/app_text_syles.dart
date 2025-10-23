import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/size_config.dart';

class AppTextSyles {
  static TextStyle textStyle24re(BuildContext context) => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    color: AppColors.kprimarycolor,
  );
  static TextStyle textStyle16se(BuildContext context) => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    color: AppColors.kprimarycolor,
  );
  static TextStyle textStyle11se(BuildContext context) => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, fontSize: 11),
    color: Colors.white,
  );
  static TextStyle textStyle80se(BuildContext context) => TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, fontSize: 80),
    color: AppColors.kprimarycolor,
  );
  static TextStyle textStyle20b(BuildContext context) => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    color: Colors.white,
  );
  static TextStyle textStyle14b(BuildContext context) => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    color: Colors.white,
  );
}

/// دالة حساب حجم الخط Responsive
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

/// دالة تحديد الـ Scale حسب عرض الشاشة
double getScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}

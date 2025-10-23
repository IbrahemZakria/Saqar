import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';

class AhadesBackground extends StatelessWidget {
  const AhadesBackground({
    super.key,
    required this.header,
    required this.content,
  });
  final String header, content;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(Assets.resourceImagesMoshaf),
        ),
        color: AppColors.kprimarycolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.resourceImagesBlackLeftCorner),
                Image.asset(Assets.resourceImagesBlackRightCorner),
              ],
            ),
          ),
          Positioned(
            top: height * 0.06,
            left: 16,
            right: 16,
            child: Center(
              child: Text(
                header,
                textAlign: TextAlign.center,
                style: AppTextSyles.textStyle24re(
                  context,
                ).copyWith(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: 16,
            right: 16,
            bottom: height * 0.12,
            child: SingleChildScrollView(
              child: Text(
                content,
                textAlign: TextAlign.right,
                style: AppTextSyles.textStyle16se(
                  context,
                ).copyWith(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              Assets.resourceImagesMosque02,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:atrega/core/helper/thems/app_colors.dart';
import 'package:atrega/core/helper/widgets/show_dialog.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showNotificationDialog(context);
      },
      child: Icon(
        Icons.notifications_none,
        color: AppColors.kprimarycolor,
        size: 50,
      ),
    );
  }
}

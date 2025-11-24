import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/core/helper/thems/app_colors.dart';
import 'package:atrega/core/helper/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.notifications_none,
        color: AppColors.kprimarycolor,
        size: 50,
      ),
      onPressed: () {
        showNotificationDialog(context);
      },
    );
  }
}

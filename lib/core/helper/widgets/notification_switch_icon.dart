import 'package:flutter/material.dart';

class NotificationSwitchIcon extends StatelessWidget {
  const NotificationSwitchIcon({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });
  final String title;
  final bool value;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.green,
        ),
      ],
    );
  }
}

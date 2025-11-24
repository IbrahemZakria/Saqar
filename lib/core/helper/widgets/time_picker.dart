import 'package:flutter/material.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_cubit.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.title,
    required this.value,
    required this.cubit,
    required this.id,
    required this.initialTime,
  });

  final String title;
  final bool value;
  final NotificationCubit cubit;
  final int id;
  final TimeOfDay initialTime;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(widget.title)),
            Switch(
              value: widget.value,
              onChanged: (v) async {
                if (v) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );

                  if (time != null) {
                    setState(() => selectedTime = time);
                  }
                }

                // هنا بقى بتبعت الوقت المظبوط بعد الاختيار
                widget.cubit.updateSwitch(widget.title, v, selectedTime);
              },
              activeThumbColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

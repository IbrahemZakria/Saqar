import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atrega/core/helper/cubit/notification/notification_cubit.dart';
import 'package:atrega/core/helper/cubit/notification/notification_state.dart';
import 'package:atrega/core/helper/functions/notification_service.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  void _showDialog(BuildContext context) {
    final cubit = context.read<NotificationCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) => AlertDialog(
          title: const Text("إعدادات الإشعارات", textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimePicker(
                  context,
                  "أذكار الصباح",
                  state.morningAzkar,
                  cubit,
                  1,
                  TimeOfDay(hour: 6, minute: 30),
                ),
                _buildTimePicker(
                  context,
                  "أذكار المساء",
                  state.eveningAzkar,
                  cubit,
                  2,
                  TimeOfDay(hour: 19, minute: 0),
                ),
                _buildIntervalPicker(
                  context,
                  "أذكار طول اليوم",
                  state.dailyAzkar,
                  cubit,
                  3,
                  30,
                ),
                _buildSwitch("أذان الصلاة", state.adanEnabled, (v) {
                  cubit.toggleAdan(v);
                  if (v) {
                    LocalNotificationService.scheduleAdan();
                  } else {
                    LocalNotificationService.cancelAdan();
                  }
                }),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("إغلاق"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title)),
        Switch(value: value, onChanged: onChanged, activeColor: Colors.green),
      ],
    );
  }

  Widget _buildTimePicker(
    BuildContext context,
    String title,
    bool value,
    NotificationCubit cubit,
    int id,
    TimeOfDay initialTime,
  ) {
    TimeOfDay selectedTime = initialTime;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title)),
            Switch(
              value: value,
              onChanged: (v) async {
                if (v) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (time != null) selectedTime = time;
                  await LocalNotificationService.scheduleNotification(
                    id: id,
                    title: title,
                    body: "حان وقت $title",
                    hour: selectedTime.hour,
                    minute: selectedTime.minute,
                    repeats: true,
                  );
                } else {
                  await LocalNotificationService.cancelNotification(id);
                }
                cubit.updateSwitch(title, v, selectedTime);
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntervalPicker(
    BuildContext context,
    String title,
    bool value,
    NotificationCubit cubit,
    int id,
    int initialMinutes,
  ) {
    int interval = initialMinutes;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("$title ($interval دقيقة)")),
            Switch(
              value: value,
              onChanged: (v) async {
                if (v) {
                  final result = await showDialog<int>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("اختر الفاصل الزمني بالدقائق"),
                      content: Slider(
                        value: interval.toDouble(),
                        min: 5,
                        max: 180,
                        divisions: 35,
                        label: "$interval",
                        onChanged: (val) {
                          interval = val.toInt();
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, interval),
                          child: const Text("حفظ"),
                        ),
                      ],
                    ),
                  );
                  if (result != null) interval = result;

                  await LocalNotificationService.scheduleRepeatedNotification(
                    id: id,
                    title: title,
                    body: "ذكر اليوم",
                    intervalMinutes: interval,
                  );
                } else {
                  await LocalNotificationService.cancelNotification(id);
                }
                cubit.updateSwitch(title, v, TimeOfDay(hour: 0, minute: 0));
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications_none, color: Colors.green),
      onPressed: () => _showDialog(context),
    );
  }
}

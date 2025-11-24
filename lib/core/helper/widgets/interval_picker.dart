import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_cubit.dart';
import 'package:flutter/material.dart';

class IntervalPicker extends StatefulWidget {
  const IntervalPicker({
    super.key,
    required this.title,
    required this.value,
    required this.cubit,
    required this.id,
    required this.initialMinutes,
  });
  final String title;
  final bool value;
  final NotificationCubit cubit;
  final int id;
  final int initialMinutes;

  @override
  State<IntervalPicker> createState() => _IntervalPickerState();
}

class _IntervalPickerState extends State<IntervalPicker> {
  late int interval;

  @override
  void initState() {
    super.initState();
    interval = widget.initialMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("${widget.title} ($interval دقيقة)")),
            Switch(
              value: widget.value,
              onChanged: (v) async {
                if (v) {
                  final result = await showDialog<int>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("اختر الفاصل الزمني بالدقائق"),
                      content: StatefulBuilder(
                        builder: (context, setStateDialog) {
                          return Slider(
                            value: interval.toDouble(),
                            min: 5,
                            max: 180,
                            divisions: 35,
                            label: "$interval",
                            onChanged: (val) {
                              setStateDialog(() {
                                interval = val.toInt();
                              });
                              setState(() {});
                            },
                          );
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

                  widget.cubit.azkarNotification(
                    isActive: true,
                    timefreuency: interval,
                  );
                } else {
                  widget.cubit.azkarNotification(
                    isActive: false,
                    timefreuency: interval,
                  );
                }
              },
              activeThumbColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

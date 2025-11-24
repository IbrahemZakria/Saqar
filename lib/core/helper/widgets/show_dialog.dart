import 'package:atrega/core/helper/widgets/interval_picker.dart';
import 'package:atrega/core/helper/widgets/notification_switch_icon.dart';
import 'package:atrega/core/helper/widgets/time_picker.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/presentation/cubit/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showNotificationDialog(BuildContext context) {
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
              TimePicker(
                title: "أذكار الصباح",
                value: state.morningAzkar,
                cubit: cubit,
                id: 1,
                initialTime: TimeOfDay(hour: 6, minute: 30),
              ),
              TimePicker(
                title: "أذكار المساء",
                value: state.eveningAzkar,
                cubit: cubit,
                id: 2,
                initialTime: TimeOfDay(hour: 19, minute: 0),
              ),
              IntervalPicker(
                title: "أذكار طول اليوم",
                value: state.dailyAzkar,
                cubit: cubit,
                id: 3,
                initialMinutes: state.dailyInterval,
              ),
              NotificationSwitchIcon(
                title: "أذان الصلاة",
                value: state.adanEnabled,
                onChanged: (v) {
                  // Let the cubit/repository handle scheduling/cancellation
                  cubit.toggleAdan(v);
                },
              ),
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

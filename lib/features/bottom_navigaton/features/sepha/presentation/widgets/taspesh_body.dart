import 'package:atrega/core/helper/thems/app_colors.dart';
import 'package:atrega/core/helper/thems/app_text_syles.dart';
import 'package:atrega/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_cubit.dart';
import 'package:atrega/features/bottom_navigaton/features/sepha/presentation/cubit/sepha_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaspeshBody extends StatelessWidget {
  const TaspeshBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, state) {
        final cubit = context.read<TasbeehCubit>();

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: AppColors.kopacityBlackColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                  /// Dropdown للفئة
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.selectedCategory,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: "أذكار الصلاة",
                            child: Text("أذكار الصلاة"),
                          ),
                          DropdownMenuItem(
                            value: "اختيارات الأذكار",
                            child: Text("اختيارات الأذكار"),
                          ),
                        ],
                        onChanged: (v) => cubit.changeCategory(v!),
                      ),
                    ),
                  ),

                  /// Dropdown للأذكار الأخرى (اختيارات الأذكار)
                  if (state.selectedCategory == "اختيارات الأذكار") ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: state.selectedZikr.isEmpty
                              ? null
                              : state.selectedZikr,
                          hint: Text(
                            "اختر ذكرًا",
                            style: AppTextSyles.textStyle24re(context),
                          ),
                          isExpanded: true,
                          items: cubit.choiceAzkar
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (v) => cubit.selectChoiceZikr(v!),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 50),

                  /// الذكر الحالي
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.kopacityBlackColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        cubit.currentZikr,
                        textAlign: TextAlign.center,
                        style: AppTextSyles.textStyle24re(context),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// العداد لكل ذكر
                  Text(
                    "العدد: ${cubit.currentCount}",
                    style: AppTextSyles.textStyle24re(context),
                  ),

                  const SizedBox(height: 30),

                  /// زر السَبِّح
                  ElevatedButton(
                    onPressed: cubit.increment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("سَبِّح", style: const TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 15),

                  /// زر Reset
                  ElevatedButton(
                    onPressed: cubit.reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: AppTextSyles.textStyle20b(
                        context,
                      ).copyWith(color: const Color.fromARGB(255, 153, 32, 32)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/domain/entities/adhkar_category_entity.dart';

class AzkarItemsScreen extends StatelessWidget {
  final AdhkarCategoryEntity category;
  const AzkarItemsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final azkar = category.azkar ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.kprimarycolor),
        backgroundColor: Colors.transparent,
        title: Text(category.title, style: AppTextSyles.textStyle24re(context)),
      ),
      body: azkar.isEmpty
          ? const Center(child: Text('لا يوجد اذكار'))
          : ListView.builder(
              itemCount: azkar.length,
              itemBuilder: (context, index) {
                final item = azkar[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kprimarycolor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    textAlign: TextAlign.right,
                    item.text,
                    style: AppTextSyles.textStyle16se(
                      context,
                    ).copyWith(color: Colors.black87),
                  ),
                );
              },
            ),
    );
  }
}

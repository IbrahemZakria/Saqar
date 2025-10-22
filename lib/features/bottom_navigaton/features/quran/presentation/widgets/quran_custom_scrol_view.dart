import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_widget.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/most_recently_item.dart';

class QuranCustomScrolView extends StatelessWidget {
  const QuranCustomScrolView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Text(
                textAlign: TextAlign.left,
                "Most Recently",
                style: AppTextSyles.textStyle11se(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130, // 👈 ارتفاع القائمة الأفقية
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MostRecentlyItem();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                textAlign: TextAlign.left,
                "Suras list",
                style: AppTextSyles.textStyle11se(context),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: 16,
            itemBuilder: (context, index) {
              return AyaWidget();
            },
            separatorBuilder: (context, index) {
              return Divider(endIndent: 45, indent: 45, thickness: 1);
            },
          ),
        ],
      ),
    );
  }
}

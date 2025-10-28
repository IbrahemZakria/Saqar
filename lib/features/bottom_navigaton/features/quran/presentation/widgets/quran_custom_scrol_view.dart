import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_widget.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/most_recently_item.dart';

class QuranCustomScrolView extends StatelessWidget {
  const QuranCustomScrolView({super.key, required this.suras});
  final List<SuraEntity> suras;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (suras.length == 114) ...[
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
          ],
          if (suras.length == 114) ...[
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
          ],
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Text(
                textAlign: TextAlign.left,
                "Suras list",
                style: AppTextSyles.textStyle11se(context),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: suras.length,
            itemBuilder: (context, index) {
              return AyaWidget(suraEntity: suras[index]);
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

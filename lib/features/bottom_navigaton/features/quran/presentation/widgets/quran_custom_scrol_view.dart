import 'package:flutter/material.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/domain/entities/sura_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/quran/presentation/widgets/aya_widget.dart';

class QuranCustomScrolView extends StatelessWidget {
  const QuranCustomScrolView({super.key, required this.suras});
  final List<SuraEntity> suras;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: SizedBox(height: 16),
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

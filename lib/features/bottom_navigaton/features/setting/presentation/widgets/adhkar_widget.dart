import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/cubit/adhkar/adhkar_cubit.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/azkar_item_screen.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/azkar_loading.dart';
import 'package:saqar/features/bottom_navigaton/features/setting/presentation/widgets/category_card.dart';

class AdhkarWidget extends StatefulWidget {
  const AdhkarWidget({super.key});

  @override
  State<AdhkarWidget> createState() => _AdhkarWidgetState();
}

class _AdhkarWidgetState extends State<AdhkarWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AdhkarCubit>().loadCategoriesWithAzkar();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdhkarCubit, AdhkarState>(
      builder: (context, state) {
        if (state is AdhkarLoading) {
          return const AzkarLoading();
        } else if (state is AdhkarLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: state.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return AdhkarCategoryCard(
                category: category,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AzkarItemsScreen(category: category),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is AdhkarError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

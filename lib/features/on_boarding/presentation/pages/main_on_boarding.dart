import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atrega/core/helper/thems/app_text_syles.dart';
import 'package:atrega/core/utils/assets.dart';
import 'package:atrega/features/bottom_navigaton/features/quran/presentation/pages/quran_page.dart';
import 'package:atrega/features/on_boarding/presentation/data/models/onboarding_model.dart';
import 'package:atrega/features/on_boarding/presentation/widgets/doted_indicator.dart';
import 'package:atrega/features/on_boarding/presentation/widgets/page_view_item.dart';

class MainOnBoarding extends StatefulWidget {
  static const String routeName = "/MainOnBoarding";
  const MainOnBoarding({super.key});

  @override
  State<MainOnBoarding> createState() => _MainOnBoardingState();
}

class _MainOnBoardingState extends State<MainOnBoarding> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<OnboardingModel> models = [
    OnboardingModel(
      img: Assets.resourceImagesWelcome,
      suTitel:
          "قال ﷺ: «مثلُ المؤمنِ الذي يقرأُ القرآنَ مثلُ الأُترُجَّةِ، طعمُها طيِّبٌ وريحُها طيِّبٌ\n"
          "ومثلُ المؤمنِ الذي لا يقرأُ القرآنَ مثلُ التمرةِ، طعمُها طيِّبٌ ولا ريحَ لها\n"
          "ومثلُ المنافقِ الذي يقرأُ القرآنَ مثلُ الرَّيحانةِ، ريحُها طيِّبٌ وطعمُها مُرٌّ\n"
          "ومثلُ المنافقِ الذي لا يقرأُ القرآنَ مثلُ الحنظلةِ، طعمُها مُرٌّ ولا ريحَ لها.»",
      index: 0,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding1,
      titel: "الأُترُجَّةِ",
      suTitel:
          'باسم الله نرحب بك في مجتمعنا، ونسأل الله أن يكون هذا التطبيق نورًا في حياتك اليومية🌙',
      index: 1,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding2,
      titel: "قراءة القرآن",
      suTitel: 'اقرأ، وربك هو الأكرم🌙📖',
      index: 2,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding3,
      titel: "سبح",
      suTitel: 'سبح اسم ربك الأعلى 🌙',
      index: 3,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding4,
      titel: "راديو القرآن الكريم",
      suTitel: 'استمتع بالاستماع إلى القرآن الكريم في أي وقت، مجانًا وبسهولة✨',
      index: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: models.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return PageViewItem(
                      onboardingModel: models[index],
                      modelLenth: models.length,
                      pageController: pageController,
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: currentPage != 0 ? 1 : 0,
                        child: TextButton(
                          onPressed: () {
                            if (currentPage != 0) {
                              pageController.animateToPage(
                                currentPage - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            "Back",
                            style: AppTextSyles.textStyle16se(context),
                          ),
                        ),
                      ),

                      DotedIndicator(
                        length: models.length,
                        currentPage: currentPage,
                        onDotClicked: (index) {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          if (currentPage == models.length - 1) {
                            context.go(QuranPage.routeName);
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          currentPage != models.length - 1 ? "Next" : "Finish",
                          style: AppTextSyles.textStyle16se(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Visibility(
              visible: currentPage != models.length - 1,
              child: TextButton(
                onPressed: () {
                  context.go(QuranPage.routeName);
                },
                child: Text("Skip", style: AppTextSyles.textStyle16se(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

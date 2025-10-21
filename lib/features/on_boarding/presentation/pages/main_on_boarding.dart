import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';
import 'package:saqar/core/utils/assets.dart';
import 'package:saqar/features/bottom_navigaton/features/main_bottom_navigation/presentation/pages/main_home_page.dart';
import 'package:saqar/features/on_boarding/presentation/data/models/onboarding_model.dart';
import 'package:saqar/features/on_boarding/presentation/widgets/doted_indicator.dart';
import 'package:saqar/features/on_boarding/presentation/widgets/page_view_item.dart';

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
      suTitel: "Welcome to Saqar App",
      index: 0,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding1,
      titel: "Welcome to Saqar App",
      suTitel: 'We Are Very Excited To Have You In Our Community',
      index: 1,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding2,
      titel: "Reading the Quran",
      suTitel: 'Read, and your Lord is the Most Generous',
      index: 2,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding3,
      titel: "Bearish",
      suTitel: 'Praise the name of your Lord, the Most High',
      index: 3,
    ),
    OnboardingModel(
      img: Assets.resourceImagesOnboarding4,
      titel: "Holy Quran Radio",
      suTitel:
          'You can listen to the Holy Quran Radio through the application for free and easily',
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
                            context.go(MainHomePage.routeName);
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
                  context.go(MainHomePage.routeName);
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

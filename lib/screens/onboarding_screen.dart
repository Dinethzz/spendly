import 'package:expenz/constants/colors.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_screen.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final PageController _pageController = PageController();
  bool showDetailsPage = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                showDetailsPage = index ==3 ; // Show details page after the first screen
              });
            },
            children: [
              const FrontScreen(),
              SharedOnboardingScreen(
                title: OnboardingData.onboardingData[0].title, 
                imagePath: OnboardingData.onboardingData[0].imagePath, 
                description: OnboardingData.onboardingData[0].description
              ),
              SharedOnboardingScreen(
                title: OnboardingData.onboardingData[1].title, 
                imagePath: OnboardingData.onboardingData[1].imagePath, 
                description: OnboardingData.onboardingData[1].description
              ),
              SharedOnboardingScreen(
                title: OnboardingData.onboardingData[2].title, 
                imagePath: OnboardingData.onboardingData[2].imagePath, 
                description: OnboardingData.onboardingData[2].description
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 4, // FrontScreen + 3 onboarding screens
              effect: const ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: kMainColor,
                dotColor: kGrey,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: !showDetailsPage ? GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    _pageController.page!.toInt() + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut
                  );
                },
                child: CustomButton(buttonName: showDetailsPage? "Get Started" : "Next", buttonColor: kMainColor)) : GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute (
                    builder: (context) => const UserDataScreen()
                  ));
                },
                child: CustomButton(buttonName: showDetailsPage? "Get Started" : "Next", buttonColor: kMainColor)),
            ))
        ],
      )
    );
  }
}
import 'package:expenz/models/onboarding_model.dart';

class OnboardingData {
  static final List<Onboarding> onboardingData = [
    Onboarding(
      title: 'Gain control of your expenses',
      imagePath: 'assets/images/onboard1.png',
      description: 'Become your own financial boss with Spendly.',
    ),
    Onboarding(
      title: 'Keep track of your spending',
      imagePath: 'assets/images/onboard2.png',
      description: 'Track your expenses effortlessly with Spendly.',
    ),
    Onboarding(
      title: 'Analyze your spending habits',
      imagePath: 'assets/images/onboard3.png',
      description: 'Get insights into your spending habits.',
    ),
  ];
}
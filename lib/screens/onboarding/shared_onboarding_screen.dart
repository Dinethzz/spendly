import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  const SharedOnboardingScreen({super.key, required this.title, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200, width: 200, fit: BoxFit.cover),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: kBlack,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

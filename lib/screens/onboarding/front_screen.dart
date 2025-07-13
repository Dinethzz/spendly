import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/appIcon.png", height: 200, width: 200, fit: BoxFit.cover),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Spendly!',
            style: TextStyle(
              color: kMainColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
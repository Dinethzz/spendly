import 'package:expenz/models/expence_model.dart';
import 'package:expenz/widgets/expence_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ExpenceCard(
              title: 'Groceries',
              description: 'Bought groceries from the supermarket',
              date: DateTime.now(),
              amount: 50.0,
              category: ExpenceCategories.food,
              time: DateTime.now(),
            ),
          ],
        )
      ),
    );
  }
}
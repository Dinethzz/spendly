import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final double amount;
  final double totalAmount;
  final Color progressColor;
  final bool isExpense;

  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.totalAmount,
    required this.progressColor,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalAmount > 0 ? (amount / totalAmount) : 0.0;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              Text(
                '${isExpense ? "-" : "+"}\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isExpense ? kRed : kGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: kLightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${(percentage * 100).toStringAsFixed(1)}% of total',
            style: const TextStyle(
              fontSize: 12,
              color: kGrey,
            ),
          ),
        ],
      ),
    );
  }
}

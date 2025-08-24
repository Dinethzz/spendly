import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:flutter/material.dart';

class ExpenceCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final double amount;
  final ExpenceCategories category;
  final DateTime time;

  const ExpenceCard({super.key, required this.title, required this.date, required this.amount, required this.category, required this.time, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: kMainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.shopping_cart,
            color: kMainColor,
          ),
        )
        , const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),)
            , const SizedBox(height: 5),
            Text(description, style: TextStyle(fontSize: 14, color: kGrey),)
          ],
        )
      ],)
    );
  }
}
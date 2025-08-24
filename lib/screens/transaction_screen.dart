import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/widgets/expence_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final void Function(Expence) onDismissedExpence;
  const TransactionScreen({super.key, required this.expencesList, required this.onDismissedExpence});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("See your financial report", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kMainColor),)
              , const SizedBox(height: 20),
              Text("Expences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),)
              , const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expencesList.length,
                        itemBuilder: (context, index) {
                          final expence = widget.expencesList[index];
                          return Dismissible(
                            key: ValueKey(expence),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedExpence(expence);
                              });
                            },
                            child: ExpenceCard(
                              expence: expence,
                              title: expence.title,
                              description: expence.description,
                              date: expence.date,
                              amount: expence.amount,
                              category: expence.category,
                              time: expence.time,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/expence_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final List<Income> incomesList;
  final void Function(Expence) onDismissedExpence;
  final void Function(Income) onDismissedIncome;
  const TransactionScreen({super.key, required this.expencesList, required this.onDismissedExpence, required this.incomesList, required this.onDismissedIncome});

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
                height: MediaQuery.of(context).size.height * 0.30,
                child: widget.expencesList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64,
                              color: kGrey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No expenses yet",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kGrey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Please add some expenses to track your spending",
                              style: TextStyle(
                                fontSize: 14,
                                color: kGrey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
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
              ),


              const SizedBox(height: 20),
              Text("Income", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),)
              , const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: widget.incomesList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 64,
                              color: kGrey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No income yet",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kGrey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Please add some income to track your earnings",
                              style: TextStyle(
                                fontSize: 14,
                                color: kGrey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.incomesList.length,
                              itemBuilder: (context, index) {
                                final income = widget.incomesList[index];
                                return Dismissible(
                                  key: ValueKey(income),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    setState(() {
                                      widget.onDismissedIncome(income);
                                    });
                                  },
                                  child: IncomeCard(
                                    title: income.title,
                                    description: income.description,
                                    date: income.date,
                                    amount: income.amount,
                                    category: income.category,
                                    time: income.time,
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
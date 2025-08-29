import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/expence_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:expenz/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final List<Income> incomesList;

  const HomeScreen({super.key, required this.expencesList, required this.incomesList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String username = "";

  @override
  void initState(){
    super.initState();
    //get the username from shared preferences
    _loadUserData();
  }

  _loadUserData() async {
    try {
      final userData = await UserServices.getUserData();
      if(userData["userName"] != null) {
        setState(() {
          username = userData["userName"]!;
        });
        print(username);
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Calculate total income and expenses
    double totalIncome = widget.incomesList.fold(0.0, (sum, income) => sum + income.amount);
    double totalExpenses = widget.expencesList.fold(0.0, (sum, expense) => sum + expense.amount);
    
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: kWhite,
                            )
                          ),
                          child: ClipRRect(
                            child: Image.asset("assets/images/user.png", width: 50, fit: BoxFit.cover),
                          ),  
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Hello, $username',
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.notifications, color: kMainColor, size: 35),
                          onPressed: () {
                            // Handle notification button press
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeExpenceCard(title: "Income", amount: totalIncome, imageUrl: "assets/images/income.png", bgcolor: kGreen),
                        IncomeExpenceCard(title: "Expense", amount: totalExpenses, imageUrl: "assets/images/expence.png", bgcolor: kRed),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spend Frequency",
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    LineChartSample(),
                  ],
                ),
              ),
              //recent transactions
              Padding(padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Transactions",
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                widget.expencesList.isEmpty && widget.incomesList.isEmpty
                    ? Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 48,
                              color: kGrey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "No transactions yet",
                              style: TextStyle(
                                fontSize: 14,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Builder(
                        builder: (context) {
                          // Create a combined list of transactions with their dates
                          List<Map<String, dynamic>> allTransactions = [];
                          
                          // Add expenses
                          for (var expence in widget.expencesList) {
                            allTransactions.add({
                              'type': 'expense',
                              'data': expence,
                              'date': expence.date,
                            });
                          }
                          
                          // Add incomes
                          for (var income in widget.incomesList) {
                            allTransactions.add({
                              'type': 'income',
                              'data': income,
                              'date': income.date,
                            });
                          }
                          
                          // Sort by date (most recent first)
                          allTransactions.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
                          
                          // Take first 5 transactions
                          final recentTransactions = allTransactions.take(5).toList();
                          
                          return Column(
                            children: recentTransactions.map((transaction) {
                              if (transaction['type'] == 'expense') {
                                final expence = transaction['data'] as Expence;
                                return ExpenceCard(
                                  expence: expence,
                                  title: expence.title,
                                  description: expence.description,
                                  date: expence.date,
                                  amount: expence.amount,
                                  category: expence.category,
                                  time: expence.time,
                                );
                              } else {
                                final income = transaction['data'] as Income;
                                return IncomeCard(
                                  title: income.title,
                                  description: income.description,
                                  date: income.date,
                                  amount: income.amount,
                                  category: income.category,
                                  time: income.time,
                                );
                              }
                            }).toList(),
                          );
                        },
                      )
                ]
              ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
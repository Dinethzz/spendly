import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expence_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Expence> expenceList = [];
  List<Income> incomeList = [];

  //function to fetch expences
  void fetchAllExpences() async {
    List<Expence> loadedExpences = await ExpenseService().loadExpences();
    setState(() {
      expenceList = loadedExpences;
    });
  }
  //function to fetch all incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes(context);
    setState(() {
      incomeList = loadedIncomes;
    });
  }
  //function to add a new expence
  void addNewExpence(Expence newExpence) {
    ExpenseService().saveExpences(newExpence, context);

    setState(() {
      expenceList.add(newExpence);
    });
  }
  //function to add a new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);

    setState(() {
      incomeList.add(newIncome);
      print(incomeList.length);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpences();
      fetchAllIncomes();
    });
  }

  void removeExpence(Expence expence) {
    ExpenseService().deleteExpence(expence.id, context);
    setState(() {
      expenceList.remove(expence);
    });
  }
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate category totals for budget screen
    Map<ExpenceCategories, double> expenseCategoryTotals = {};
    Map<IncomeCategory, double> incomeCategoryTotals = {};
    
    // Calculate expense totals by category
    for (var expense in expenceList) {
      expenseCategoryTotals[expense.category] = 
          (expenseCategoryTotals[expense.category] ?? 0) + expense.amount;
    }
    
    // Calculate income totals by category
    for (var income in incomeList) {
      incomeCategoryTotals[income.category] = 
          (incomeCategoryTotals[income.category] ?? 0) + income.amount;
    }

    //screen list
    final List<Widget> screens = [
      HomeScreen(
        expencesList: expenceList,
        incomesList: incomeList,
      ),
      TransactionScreen(
        expencesList: expenceList,
        incomesList: incomeList,
        onDismissedExpence: removeExpence,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpence: addNewExpence,
        addIncome: addNewIncome,
      ),
      BudgetScreen(
        expenseCategoryTotals: expenseCategoryTotals,
        incomeCategoryTotals: incomeCategoryTotals,
      ),
      const ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            print('Tapped on index: $index');
            print('Current index before: $_currentPageIndex');
            _currentPageIndex = index;
            print('Current index after: $_currentPageIndex');
          });
        },
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: kGrey,
        ),
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded),
          label: 'Transactions',
        ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
          label: '',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.rocket),
          label: 'Budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        ]),
      body: screens[_currentPageIndex],
    );
  }
}
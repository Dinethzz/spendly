import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expence_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Expence> expenceList = [];
  //function to fetch expences
  void fetchAllExpences() async {
    List<Expence> loadedExpences = await ExpenseService().loadExpences();
    setState(() {
      expenceList = loadedExpences;
    });
  }

  //function to add a new expence
  void addNewExpence(Expence newExpence) {
    ExpenseService().saveExpences(newExpence, context);

    setState(() {
      expenceList.add(newExpence);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpences();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> screens = [
      const HomeScreen(),
      const TransactionScreen(),
      AddNewScreen(
        addExpence: addNewExpence
      ),
      const BudgetScreen(),
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
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:expenz/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                        IncomeExpenceCard(title: "Income", amount: 1200, imageUrl: "assets/images/income.png", bgcolor: kGreen),
                        IncomeExpenceCard(title: "Expence", amount: 1200, imageUrl: "assets/images/expence.png", bgcolor: kRed),
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
                    SizedBox(height: 10),
                    LineChartSample(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:flutter/material.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  //state to track expence or income
  int _selectedMethod = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                              child: Text("Expence", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _selectedMethod==0 ? kWhite : kBlack),),
                            )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                              child: Text("Income", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _selectedMethod==1 ? kWhite : kBlack),),
                            )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ) 
      )
    );
  }
}
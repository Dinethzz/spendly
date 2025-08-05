import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
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
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:   8.0),
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("How Much?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kWhite)),
                          TextField(
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: kWhite ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0.00",
                        hintStyle: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: kWhite.withOpacity(0.5) ),
                    ),
                    ),
                        ],
                      ),
                    ),
                  ),

                  //user data form
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children:[
                            //category selector dropdown
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Select Category",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              items: ExpenceCategories.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(), onChanged: (value){})
                          ]
                        ),
                      ),
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
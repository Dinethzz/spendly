import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  //state to track expence or income
  int _selectedMethod = 0;
  ExpenceCategories _expenceCategory = ExpenceCategories.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                    padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: kDefaultPadding),
                              ),
                              items: _selectedMethod==0 ? ExpenceCategories.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList()
                            :
                            IncomeCategory.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                            value: _selectedMethod == 0 ? _expenceCategory : _incomeCategory,
                            onChanged: (value){
                              if (_selectedMethod == 0) {
                                setState(() {
                                  _expenceCategory = value as ExpenceCategories;
                                });
                              } else {
                                setState(() {
                                  _incomeCategory = value as IncomeCategory;
                                });
                              }
                            }),
                            const SizedBox(height: 16),
                            //title field
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: kDefaultPadding),
                              ),
                            ),
                            const SizedBox(height: 16),
                            //description field
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                labelText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: kDefaultPadding),
                              ),
                            ),
                            const SizedBox(height: 16),
                            //amount field
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Amount",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: kDefaultPadding),
                              ),
                            ),
                            const SizedBox(height: 16),
                            //date picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context, 
                                    firstDate: DateTime(2020), 
                                    lastDate: DateTime(2025), 
                                    initialDate: DateTime.now()).then((value){
                                      if(value != null){
                                        setState(() {
                                          _selectedDate = value;
                                        });
                                      }
                                    });

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: kGrey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Select Date",
                                           style: TextStyle(
                                           color: kWhite,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              Text(DateFormat.yMMMd().format(_selectedDate), // Display selected date
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            ),
                            const SizedBox(height: 16),

                            //Time picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context, 
                                    initialTime: TimeOfDay.now()).then((value){
                                      if(value != null){
                                        setState(() {
                                          _selectedTime = DateTime(
                                            _selectedDate.year,
                                            _selectedDate.month,
                                            _selectedDate.day,
                                            value.hour,
                                            value.minute
                                          );
                                        });
                                      }
                                    });

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kYellow,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: kGrey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer_sharp,
                                          color: kBlack,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Select Time",
                                           style: TextStyle(
                                           color: kBlack,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              Text(DateFormat.jm().format(_selectedTime), // Display selected time
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: kGrey,
                              thickness: 1,
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                // Handle button tap
                              },
                              child: CustomButton(
                                buttonName: "Add", buttonColor: _selectedMethod == 0 ? kRed : kGreen),
                            )
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
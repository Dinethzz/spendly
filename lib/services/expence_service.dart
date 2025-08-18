import 'dart:convert';
import 'package:expenz/models/expence_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  
  //expense list
  List<Expence> expenceList = [];

  //define the key for storing expenses in shared preferences
  static const String _expenceKey = 'expences';

  //save the expences to shared preferences
  Future<void> saveExpences(Expence expence, BuildContext context) async {
   try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpences = prefs.getStringList(_expenceKey);
      List<Expence> existingExpencesObjects = [];
      if(existingExpences != null) {
        existingExpencesObjects = existingExpences.map((e) => Expence.fromJson(json.decode(e))).toList();
      }
      existingExpencesObjects.add(expence);

      //convert the list of expence objects back to a list of strings
      List<String> updatedExpences = existingExpencesObjects.map((e) => json.encode(e.toJson())).toList();
      await prefs.setStringList(_expenceKey, updatedExpences);
      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Expense saved successfully!'), duration: Duration(seconds: 2)),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving expense: $error'), duration: Duration(seconds: 2)),
        );
      }
    }
  }

  //Load the expences from shared preferences
  Future<List<Expence>> loadExpences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? expences = pref.getStringList(_expenceKey);

    //convert the existing expense strings to Expence objects
    List<Expence> loadedexpences = [];
    if (expences != null) {
      loadedexpences = expences.map((e) => Expence.fromJson(json.decode(e))).toList();
    }
    return expenceList;
  }
}

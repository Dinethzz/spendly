import 'dart:convert';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //Define the key for storing incomes in shared pref
  static const String _incomeKey = 'incomes';

  //save the income to shared pref
  Future <void> saveIncome (Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncomes = prefs.getStringList(_incomeKey);
    List<Income> existingIncomeObjects = [];
    if(existingIncomes != null) {
      existingIncomeObjects = existingIncomes.map((e) => Income.fromJson(jsonDecode(e))).toList();
    }
    existingIncomeObjects.add(income);
    List<String> updatedIncomes = existingIncomeObjects.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_incomeKey, updatedIncomes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Income added successfully!'), duration: Duration(seconds: 2)
      ),
    );
  } catch (e) {
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add income: $e'), duration: Duration(seconds: 2)
        ),
      );
    }
   }
  }
  //Load the incomes from shared pref
  Future<List<Income>> loadIncomes(BuildContext context) async {
    List<Income> loadedIncomes = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);
      if (existingIncomes != null) {
        loadedIncomes = existingIncomes.map((e) => Income.fromJson(jsonDecode(e))).toList();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load incomes: $e'), duration: Duration(seconds: 2)
          ),
        );
      }
    }
    return loadedIncomes;
  }

  //function to delete an income
  Future<void> deleteIncome(int incomeId, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);
      if (existingIncomes != null) {
        List<Income> existingIncomeObjects = existingIncomes.map((e) => Income.fromJson(jsonDecode(e))).toList();
        existingIncomeObjects.removeWhere((income) => income.id == incomeId);
        List<String> updatedIncomes = existingIncomeObjects.map((e) => jsonEncode(e.toJson())).toList();
        await prefs.setStringList(_incomeKey, updatedIncomes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Income deleted successfully!'), duration: Duration(seconds: 2)
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete income: $e'), duration: Duration(seconds: 2)
          ),
        );
      }
    }
  }
}
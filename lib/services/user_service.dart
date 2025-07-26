import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices{
  static Future <void> storeUserDetails({
     required String userName,
     required String email,
     required String password,
     required String confirmPassword,
     required BuildContext context,
  }) async {
    
    //if the passwords match, you can proceed to store the user details
    try{
      if(password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', userName);
  await prefs.setString('email', email);

      //show a message that the user details have been stored successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details stored successfully!')),
      );

      await prefs.setString('password', password);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error storing user details: $error')),
      );
    }
  }

  //method to check whether the username is saved in SharedPreferences
  static Future<bool> checkUserName() async {
    //create an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    return userName != null;
  }

  //get username and email
  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    String? email = prefs.getString('email');
    return {'userName': userName, 'email': email};
  }
}
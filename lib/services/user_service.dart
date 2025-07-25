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
}

import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); // Ensure SharedPreferences is initialized
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: UserServices.checkUserName(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      else{
        // here the hasUserName variable will be true if the userName is saved in SharedPreferences
        bool hasUserName = snapshot.data ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spendly',
          theme: ThemeData(
            fontFamily: 'Inter',
          ),
          home: Wrapper(showMainScreen: hasUserName)
        );
      }
    });
  }
}
import 'package:expenz/constants/colors.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(    
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Enter your personal Details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
            TextFormField(
              controller: _userNameController,
              validator: (value){
                if(value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              validator: (value){
                if(value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'email',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              validator: (value){
                if(value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordController,
              validator: (value){
                if(value!.isEmpty) {
                  return 'Please enter confirm password';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Remember me for the next time",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Expanded(child: CheckboxListTile(
                  activeColor: kMainColor,
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                )),
              ],
            ),
            const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String userName = _userNameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String confirmPassword = _confirmPasswordController.text;
                    }
                  },
                  child: CustomButton(
                    buttonName: "Next", buttonColor: kMainColor))
                ],
              ),
            ),
          ],
        ),
      )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';
import 'package:groundbooking/widjents/textfield.dart';
import 'package:image_picker/image_picker.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  

 

 
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              
              children: [
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,),
                ),
               
               
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'Username',
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else if (value.length < 3) {
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return 'Must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
               
                
                
                
               
                
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // You can also access the input values directly from the controllers
                     print('hello');
                    await loginUser(usernameController.text, passwordController.text,context);
                      print('hello3');
                    }
                  },
                  child: Text('Login'),
                ),
                 SizedBox(height: 10),
              ],
            ),
          ),
        ),
     ),
);
}
}

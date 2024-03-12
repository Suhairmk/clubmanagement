import 'package:flutter/material.dart';
import 'package:groundbooking/login.dart';
import 'package:groundbooking/register.dart';
import 'package:groundbooking/screens/groundbooking.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      home: Login(),
    );
  }
}





void navigation(context,screen){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
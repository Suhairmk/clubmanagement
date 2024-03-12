import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';
import 'package:groundbooking/gallary.dart';
import 'package:groundbooking/news.dart';
import 'package:groundbooking/screens/gallery.dart';
import 'package:groundbooking/main.dart';
import 'package:groundbooking/screens/groundbooking.dart';
import 'package:groundbooking/screens/news.dart';
import 'package:groundbooking/widjents/container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(context, ()async{
              navigation(context, Gallery());
             
              
            }, 'View Gallery'),

            SizedBox(height: 30,),
             buildContainer(context, ()async{
              navigation(context, ViewNews());
              Future.delayed(Duration(seconds: 5),);
            
             
             }, 'Newses'),

             buildContainer(context, (){
              navigation(context, GroundBookingScreen());
             }, 'Ground Booking')
          ],
        ),

    ),
);
}
}
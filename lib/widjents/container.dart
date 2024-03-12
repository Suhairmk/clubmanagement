import 'package:flutter/material.dart';
import 'package:groundbooking/main.dart';
import 'package:groundbooking/screens/gallery.dart';

@override
Widget buildContainer(BuildContext context,ontap,text) {
  return  InkWell(
          onTap:ontap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            height: 60,
            width: 100,
            child: Center(child: Text(text)),
         ),
);
}
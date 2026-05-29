import 'package:flutter/material.dart';
import 'package:lms/screens/profile_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blue[700],
    title: Padding(
      padding: EdgeInsets.all(0),
      child: Text(
        "Library Management",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.notifications, color: Colors.black ,),
        onPressed: () {
          // Notification functionality here
        },
      ),
      IconButton(
        icon: Icon(Icons.account_circle, size: 30, color: Colors.black,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
      ),
    ],
  );
}

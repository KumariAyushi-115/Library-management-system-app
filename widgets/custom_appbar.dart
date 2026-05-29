import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double height;

  const CustomAppBar({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.blue,
      padding: EdgeInsets.only(top:50.0,bottom:2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/library_logo.png', // Ensure you have a logo in assets
            height: height * 0.6,
          ),
          SizedBox(
            width: 10,
          ),
          Text(

            "Library Management",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),

        ],
      ),
    );
  }
}

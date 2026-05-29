import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lms/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/library_logo.png',
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(height: 100),
          //const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child:
              const LinearProgressIndicator(
              minHeight: 8,
              backgroundColor: Colors.grey,
              color: Colors.blue,
          ),
          )
          ),
        ],
      ),
    );
  }
}

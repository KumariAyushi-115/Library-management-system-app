import 'package:flutter/material.dart';
import 'screens/auth/splash_screen.dart';
import 'package:lms/database/book_repo.dart';
import 'package:lms/database/user_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Insert data when app starts
  await UserRepository.insertUsers();
  await BookRepository.fetchAndStoreBooks();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'library management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}

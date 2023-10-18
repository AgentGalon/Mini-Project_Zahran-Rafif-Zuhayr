import 'package:flutter/material.dart';

import 'package:car_wash_app/screens/home_screen.dart';
import 'package:car_wash_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: isLoggedIn ? const HomeScreen() : const LoginPage(),
    );
  }
}

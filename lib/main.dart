import 'package:flutter/material.dart';
import 'package:group_13_priolearn/pages/hi_student.dart';
import 'package:group_13_priolearn/pages/home.dart';
import 'package:group_13_priolearn/pages/login.dart';
import 'package:group_13_priolearn/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, 
        // home: ((Splash()))

        home: Home());
  }
}

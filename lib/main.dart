import 'package:flutter/material.dart';
import 'package:group_13_priolearn/pages/hi_student.dart';
import 'package:group_13_priolearn/pages/home/home.dart';
import 'package:group_13_priolearn/pages/login.dart';
import 'package:group_13_priolearn/pages/save_al_page.dart';
import 'package:group_13_priolearn/pages/sign_up.dart';
import 'package:group_13_priolearn/pages/welcome.dart';
import 'package:group_13_priolearn/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: ((Home())));
  }
}

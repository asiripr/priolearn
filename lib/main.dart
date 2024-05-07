import 'package:flutter/material.dart';
import 'package:group_13_priolearn/add_task.dart';
import 'package:group_13_priolearn/authentication/welcome.dart';
import 'package:group_13_priolearn/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ((AddTask())));
  }
}

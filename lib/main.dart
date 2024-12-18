import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/splash.dart';
import 'package:group_13_priolearn/to_do/add_task.dart';
import 'package:group_13_priolearn/to_do/to_do.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAwqqPS1Y_eC_WwptyqgKo9DJgJJbaJnr4',
          appId: '1:960735729859:android:e9b87b331192199e8a6a76',
          messagingSenderId: '960735729859',
          projectId: 'priolearn'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ((Splash())));
  }
}

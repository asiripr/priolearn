import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/academic/ComMathsContentPage.dart';
import 'package:group_13_priolearn/academic/ComMathsPage.dart';
import 'package:group_13_priolearn/pages/contact.dart';
import 'package:group_13_priolearn/academic/select_subject.dart';
import 'package:group_13_priolearn/extra_pages/Streams.dart';
import 'package:group_13_priolearn/get_secondary_information/Student.dart';
import 'package:group_13_priolearn/academic/choose_lesson.dart';
import 'package:group_13_priolearn/authentication/login.dart';
import 'package:group_13_priolearn/authentication/welcome.dart';
import 'package:group_13_priolearn/mindfulness/mood_check.dart';
import 'package:group_13_priolearn/mindfulness/stress_relief_page.dart';
import 'package:group_13_priolearn/pages/new_home.dart';
import 'package:group_13_priolearn/settings/account.dart';
import 'package:group_13_priolearn/settings/help.dart';
import 'package:group_13_priolearn/settings/profile.dart';
import 'package:group_13_priolearn/splash.dart';
import 'package:group_13_priolearn/to_do/add_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyAwqqPS1Y_eC_WwptyqgKo9DJgJJbaJnr4', 
    appId: '1:960735729859:android:e9b87b331192199e8a6a76', 
    messagingSenderId: '960735729859', 
    projectId: 'priolearn'
    )
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: ((Splash())));
  }
}

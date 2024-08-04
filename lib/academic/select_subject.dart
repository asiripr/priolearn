import 'package:flutter/material.dart';
import 'package:group_13_priolearn/academic/choose_lesson.dart';
import 'package:group_13_priolearn/mindfulness/mindfulness_screen.dart';
import 'package:group_13_priolearn/pages/new_home.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';
import 'package:group_13_priolearn/utils/button_white.dart';

class SelectSubject extends StatefulWidget {
  const SelectSubject({super.key});

  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Academics"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Select a subject for save details...',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              subjectButton(context, "Physics",() => _navigateToChooseLesson(context, 'physics')),
              const SizedBox(height: 30),
              subjectButton(context, "Chemistry",() => _navigateToChooseLesson(context, 'chemistry')),
              const SizedBox(height: 30),
              subjectButton(context, "Applied",() => _navigateToChooseLesson(context, 'applied')),
              const SizedBox(height: 30),
              subjectButton(context, "Pure",() => _navigateToChooseLesson(context, 'pure_maths')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  _navigateToChooseLesson(BuildContext context, String subjectName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseLesson(
          subjectName: subjectName,
        ),
      ),
    );
  }
}
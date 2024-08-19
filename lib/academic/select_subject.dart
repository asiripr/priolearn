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
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove shadow
        title: const Text(
          "My Academics",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Select a subject to save details...',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              _subjectButton(context, "Physics",
                  () => _navigateToChooseLesson(context, 'physics')),
              const SizedBox(height: 20),
              _subjectButton(context, "Chemistry",
                  () => _navigateToChooseLesson(context, 'chemistry')),
              const SizedBox(height: 20),
              _subjectButton(context, "Applied Mathematics",
                  () => _navigateToChooseLesson(context, 'applied')),
              const SizedBox(height: 20),
              _subjectButton(context, "Pure Mathematics",
                  () => _navigateToChooseLesson(context, 'pure_maths')),
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

  Widget _subjectButton(
      BuildContext context, String subjectName, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity, // Make the button take full width of the parent
      height: 60.0, // Set a standard height for all buttons
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Color(0xFF4169E1)), // Royal blue border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          subjectName,
          style: const TextStyle(
            color: Color(0xFF4169E1), // Royal blue text color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateToChooseLesson(BuildContext context, String subjectName) {
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

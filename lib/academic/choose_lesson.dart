import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/button.dart';

class ChooseLesson extends StatefulWidget {
  const ChooseLesson({super.key});

  @override
  State<ChooseLesson> createState() => _ChooseLessonState();
}

class _ChooseLessonState extends State<ChooseLesson> {
  String? selectedLesson;
  String? selectedCompetency;

  List<String> lessons = [];
  List<String> competencies = [];

  void _emptyFunction1() {
    print("Button 1 pressed");
  }

  void _emptyFunction2() {
    print("Button 2 pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subject Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Lesson",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              value: selectedLesson,
              items: lessons.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLesson = newValue;
                });
              },
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Competencies",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              value: selectedCompetency,
              items: competencies.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCompetency = newValue;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _emptyFunction1,
              child: const Text("Content"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _emptyFunction2,
              child: const Text("Learning Outcomes"),
            ),
          ],
        ),
      ),
    );
  }
}

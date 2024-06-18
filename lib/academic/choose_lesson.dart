import 'package:flutter/material.dart';

class ChooseLesson extends StatefulWidget {
  const ChooseLesson({super.key});

  @override
  State<ChooseLesson> createState() => _ChooseLessonState();
}

class _ChooseLessonState extends State<ChooseLesson> {
  String? selectedLesson;
  String? selectedCompetency;

  List<String> lessons = ["Trigonometry", "Metrix", "Geometry", "Algebra"];
  List<String> competencies = ["Cm-1", "Cm-2", "Cm-3", "Cm-4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subject Name"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: "Lesson",
              border: OutlineInputBorder()
            ),
            value: selectedLesson,
            items: lessons.map((String value){
              return DropdownMenuItem(
                value: value,
                child: Text(value));
            }).toList(), 
            onChanged: (String? newValue){
              setState(() {
                selectedLesson = newValue;
              });
            }
          )
        ],
      ),
    );
  }
}
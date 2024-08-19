import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/academic/content.dart';
import 'package:group_13_priolearn/academic/learning_outcome.dart';
import 'package:group_13_priolearn/utils/button_dynamic.dart';
import 'package:group_13_priolearn/utils/button_void.dart';

class ChooseLesson extends StatefulWidget {
  final String subjectName;
  const ChooseLesson({super.key, required this.subjectName});

  @override
  State<ChooseLesson> createState() => _ChooseLessonState();
}

class _ChooseLessonState extends State<ChooseLesson> {
  String? selectedLesson;
  String? selectedCompetency;

  List<String> lessons = [];
  List<String> competencies = [];

  void _navigateToContent() {
    if (selectedLesson != null && selectedCompetency != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Content(
            subjectName: widget.subjectName,
            lessonId: selectedLesson!,
            competencyIndex: competencies.indexOf(selectedCompetency!),
          ),
        ),
      );
    }
  }

  void _navigateToLOs() {
    if (selectedLesson != null && selectedCompetency != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LOs(
            subjectName: widget.subjectName,
            lessonId: selectedLesson!,
            competencyIndex: competencies.indexOf(selectedCompetency!),
          ),
        ),
      );
    }
  }

  Future<void> _saveToDoneList() async {
    if (selectedLesson != null && selectedCompetency != null) {
      await FirebaseFirestore.instance.collection('done_list').add({
        'subjectName': widget.subjectName,
        'taskType': 'lesson',
        'lesson': selectedLesson,
        'competency': selectedCompetency,
        'createdAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved to done list')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subject Name",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  competencies = [];
                  selectedCompetency = null;
                });
                if (newValue != null) {
                  fetchCompetencies(newValue);
                }
              },
            ),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: DropdownButtonFormField(
                key: ValueKey(selectedCompetency),
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
            ),
            const SizedBox(height: 30),
            myButtonVoid(context, "Content", _navigateToContent,
                color: Color(0xFF4169E1)),
            const SizedBox(height: 20),
            myButtonVoid(context, "Learning Outcomes", _navigateToLOs,
                color: Color(0xFF4169E1)),
            // ---------- done button ----------
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _saveToDoneList,
              label: const Text("Done"),
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            )
            // ---------------------------------
          ],
        ),
      ),
    );
  }

  Future<void> fetchLessons() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(widget.subjectName).get();
    setState(() {
      lessons = querySnapshot.docs.map((doc) => doc.id).toList();
    });
  }

  Future<void> fetchCompetencies(String lessonId) async {
    final lessonDoc = await FirebaseFirestore.instance
        .collection(widget.subjectName)
        .doc(lessonId)
        .get();
    List competenciesList = lessonDoc['competencies'];
    setState(() {
      competencies = List<String>.generate(competenciesList.length, (index) {
        return "${index + 1}";
      });
    });
  }
}

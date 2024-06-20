import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LOs extends StatefulWidget {
  final String lessonId;
  final int competencyIndex;
  const LOs({super.key, required this.lessonId, required this.competencyIndex});

  @override
  State<LOs> createState() => _LOsState();
}

class _LOsState extends State<LOs> {
  List<dynamic>? learningOutcomes;
  @override
  void initState() {
    super.initState();
    fetchLearningOutcomes();
  }
Future<void> fetchLearningOutcomes() async{
    final lessonDoc = await FirebaseFirestore.instance.collection('physics').doc(widget.lessonId).get();
    List learningOutcomesList = lessonDoc['competencies'];
    setState(() {
      learningOutcomes = learningOutcomesList[widget.competencyIndex]['learning-outcomes'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learning Outcomes"),),
body: Column(
        children: [
          learningOutcomes == null ? const CircularProgressIndicator():
          Column(
            children: [
              const Text("This is the learning outcomes for selected part:"),
              const SizedBox(height: 20),
              ...learningOutcomes!.map((item)=>Text(item.toString())).toList()
            ],
          )
        ]  
      ),
    );
  }
}
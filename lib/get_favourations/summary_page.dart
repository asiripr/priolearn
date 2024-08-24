import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/mindfulness/make_happy.dart';
import 'package:group_13_priolearn/models/question_model.dart';

class SummaryPage extends StatelessWidget {
  final QuestionModel questionModel;

  const SummaryPage({super.key, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Summary",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Color(0xFF4169E1),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Answers:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questionModel.questions.length,
                itemBuilder: (context, index) {
                  final question = questionModel.questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        question.question,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(question.answer),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveFavourations(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeHappy()));
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFavourations(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final CollectionReference favorationsRef =
          FirebaseFirestore.instance.collection('favorations');

      List<Map<String, String>> answers =
          questionModel.questions.map((question) {
        return {'question': question.question, 'answer': question.answer};
      }).toList();

      await favorationsRef.add({
        'userId': user.uid,
        'answers': answers,
        'timestamp': FieldValue.serverTimestamp()
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Answers submitted successsfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
    }
  }
}

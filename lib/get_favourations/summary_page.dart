import 'package:flutter/material.dart';
import 'package:group_13_priolearn/models/question_model.dart';

class SummaryPage extends StatelessWidget {
  final QuestionModel questionModel;

  const SummaryPage({super.key, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Column(
        children: [
          for (var question in questionModel.questions)
            ListTile(
              title: Text(question.question),
              subtitle: Text(question.answer),
            ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              //_saveFavourations();
            }, 
            child: Text("Submit")
          )
        ],
      ),
    );
  }
}

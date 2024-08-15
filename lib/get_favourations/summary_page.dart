import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:group_13_priolearn/models/question_model.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionModel = Provider.of<QuestionModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Summary"),),
      body: Column(
        children: [
          for(var question in questionModel.questions)
            ListTile(
              title: Text(question.question),
              subtitle: Text(question.answer),
            ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){
              //_saveFavourations();
            }, 
            child: Text("Submit")
          )
        ],
      ),
    );
    
  }
}


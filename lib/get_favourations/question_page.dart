import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_favourations/summary_page.dart';
import 'package:group_13_priolearn/models/question_model.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionModel = Provider.of<QuestionModel>(context);
    final question = questionModel.questions[questionModel.currentPage];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${questionModel.currentPage + 1}',
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
              question.question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: textController,
              onChanged: (value) {
                questionModel.updateAnswer(questionModel.currentPage, value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter your answer here',
              ),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              color: Colors.blue,
              value: (questionModel.currentPage + 1) /
                  questionModel.questions.length,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (questionModel.currentPage <
                        questionModel.questions.length - 1) {
                      questionModel.nextPage();
                      textController.clear();
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SummaryPage(questionModel: questionModel)));
                    }
                  },
                  child: Text("Next")),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:group_13_priolearn/models/model.dart';

class QuestionModel with ChangeNotifier {
  List<Question> questions = [
    Question("Which hobby do you enjoy most?"),
    Question("What is your favourite sport?"),
    Question("Who is your favourite singer?"),
    Question("What is your dream travel destination?"),
    Question("Which movie do you enjoy the most?"),
    Question("What is your favourite dish?"),
  ];

  int currentPage = 0;

  void updateAnswer(int index, String answer) {
    questions[index].answer = answer;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < questions.length - 1) {
      currentPage++;
      notifyListeners();
    }
  }
}

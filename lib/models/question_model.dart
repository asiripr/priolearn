import 'package:flutter/material.dart';
import 'package:group_13_priolearn/models/model.dart';

class QuestionModel with ChangeNotifier {
  List<Question> questions = [
    Question("Which hobby do you enjoy most?"),
    Question("What is your favorite sport?"),
    Question("Who is your favorite singer?"),
    Question("What is your dream travel destination?"),
    Question("Which movie do you enjoy the most?"),
    Question("What is your favorite dish?"),
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

  String _generateSuggestion(String question, String answer){
    switch (question) {
      case "Which hobby do you enjoy most?":
        return "How about dedicating some time to $answer this weekend?";
      case "What is your favorite sport?":
        return "Why not catch a game of $answer soon?";
      case "Who is your favorite singer?":
        return "How about putting on some music by $answer? It might help you relax.";
      case "What is your dream travel destination?":
        return "Start planning your trip to $answer. It's always good to have something to look forward to!";
      case "Which movie do you enjoy the most?":
        return "Rewatch $answer, it's always a good time!";
      case "What is your favorite dish?":
        return "Maybe you can treat yourself to $answer sometime soon!";
      default:
        return " ";
    }
  }
}

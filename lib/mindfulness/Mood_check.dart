import 'package:flutter/material.dart';

class StressQuestionsPage extends StatefulWidget {
  const StressQuestionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StressQuestionsPageState createState() => _StressQuestionsPageState();
}

class _StressQuestionsPageState extends State<StressQuestionsPage> {
  List<int> responses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAAS-21 Stress Calculator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Please answer the following questions based on your stress levels over the past week:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 25.0),
            StressQuestion(
              question: 'I found it hard to wind down',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            StressQuestion(
              question: 'I tended to over-react to situations',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            StressQuestion(
              question: 'I felt that I was using a lot of nervous energy',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            StressQuestion(
              question: 'I found it difficult to relax',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            StressQuestion(
              question:
                  'I was intolerant of anything that kept me from getting on with what I was doing',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            StressQuestion(
              question: 'I felt scared without any good reason',
              onChanged: (int value) {
                responses.add(value);
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int stressScore = calculateTotalScore(responses);
                String stressSeverity = determineSeverity(stressScore);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Stress Result'),
                      content: Text(
                          'Stress Score: $stressScore\nSeverity: $stressSeverity'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              responses = [];
                            });
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calculate Stress Score'),
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotalScore(List<int> responses) {
    int totalScore = 0;
    for (int response in responses) {
      totalScore += response;
    }
    return totalScore * 2;
  }

  String determineSeverity(int totalScore) {
    if (totalScore >= 0 && totalScore <= 9) {
      return 'Normal';
    } else if (totalScore >= 10 && totalScore <= 13) {
      return 'Mild';
    } else if (totalScore >= 14 && totalScore <= 20) {
      return 'Moderate';
    } else if (totalScore >= 21 && totalScore <= 27) {
      return 'Severe';
    } else {
      return 'Extremely Severe';
    }
  }
}

class StressQuestion extends StatefulWidget {
  final String question;
  final ValueChanged<int> onChanged;

  const StressQuestion(
      {Key? key, required this.question, required this.onChanged})
      : super(key: key);

  @override
  _StressQuestionState createState() => _StressQuestionState();
}

class _StressQuestionState extends State<StressQuestion> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.question),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Not at all'),
            Expanded(
              child: Slider(
                value: _value.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (double value) {
                  setState(() {
                    _value = value.toInt();
                    widget.onChanged(_value);
                  });
                },
              ),
            ),
            Text('Very much'),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'stress_relief_page.dart'; // Import your existing StressReliefPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stress Calculator',
      theme: ThemeData(
        primaryColor: Color(0xFF4169E1), // Set primary color to royal blue
      ),
      home: StressQuestionsPage(),
    );
  }
}

class StressQuestionsPage extends StatefulWidget {
  @override
  _StressQuestionsPageState createState() => _StressQuestionsPageState();
}

class _StressQuestionsPageState extends State<StressQuestionsPage> {
  List<int> responses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DAAS-21 Stress Calculator',
          style: TextStyle(
            color: Color(0xFF4169E1),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ), // Set text color to royal blue
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0), // Reduced padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please answer the following questions based on your stress levels over the past week:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0), // Reduced spacing
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
              const SizedBox(height: 8.0), // Reduced spacing
              ElevatedButton(
                onPressed: () {
                  int stressScore = calculateTotalScore(responses);
                  String stressSeverity = determineSeverity(stressScore);

                  if (stressScore > 14) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StressReliefPage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Stress Result'),
                          content: Text(
                            'Stress Score: $stressScore\nSeverity: $stressSeverity\n\nYou are good to go with academics!',
                            style: const TextStyle(
                              fontSize:
                                  18, // Slightly larger font size for content
                              color: Color(0xFF4169E1),

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  responses = [];
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                      0xFF4169E1), // Set button background color to royal blue
                ),
                child: Text('Calculate Stress Score',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
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

  const StressQuestion({
    Key? key,
    required this.question,
    required this.onChanged,
  }) : super(key: key);

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
        SizedBox(height: 8.0), // Reduced spacing
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
                activeColor: Color(0xFF4169E1),
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

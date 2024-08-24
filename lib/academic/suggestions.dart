import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Suggestions extends StatefulWidget {
  final String subjectName;
  final String lessonId;
  final int competencyIndex;
  const Suggestions(
      {super.key,
      required this.subjectName,
      required this.lessonId,
      required this.competencyIndex});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  late Future<List<Map<String, dynamic>>> _suggestionsFuture;

  @override
  void initState() {
    super.initState();
    _suggestionsFuture = _fetchSuggestions();
  }

  Future<List<Map<String, dynamic>>> _fetchSuggestions() async {
    // Fetch the document for the selected lesson from Firestore
    DocumentSnapshot lessonSnapshot = await FirebaseFirestore.instance
        .collection('physics_past_papers')
        .doc(widget.lessonId)
        .get();

    // Initialize an empty list to store the suggestions
    List<Map<String, dynamic>> suggestions = [];

    if (lessonSnapshot.exists) {
      // Retrieve the competencies array from the document
      List<dynamic> competencies = lessonSnapshot['competencies'];

      // Find the specific competency based on the competencyIndex
      if (widget.competencyIndex < competencies.length) {
        var selectedCompetency = competencies[widget.competencyIndex];

        // Extract the questions from the selected competency
        List<String> questions =
            List<String>.from(selectedCompetency['questions']);

        // Populate the suggestions list with question and year
        suggestions = questions.map((q) {
          // Extract year and question parts from the string
          List<String> parts = q.split(' ');
          return {
            'question': parts
                .sublist(1)
                .join(' '), // Join the rest of the parts as the question
            'year': parts[0], // The first part is the year
          };
        }).toList();
      }
    }

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suggestions",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _suggestionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No suggestions available."));
          } else {
            var suggestions = snapshot.data!;
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                var suggestion = suggestions[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Year: ${suggestion['year']}'),
                    subtitle: Text(suggestion['question']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

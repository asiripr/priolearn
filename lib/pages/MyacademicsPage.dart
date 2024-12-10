import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/mindfulness/Mood_check.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';

class MindfulnessScreen extends StatefulWidget {
  @override
  _MindfulnessScreenState createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
  int _selectedIndex = 0;
  String _quote = "";
  String _author = "";

  @override
  void initState() {
    super.initState();
    _fetchRandomQuote();
  }

  Future<void> _fetchRandomQuote() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quotes').get();
      if (querySnapshot.docs.isNotEmpty) {
        var randomIndex = Random().nextInt(querySnapshot.docs.length);
        var randomDoc = querySnapshot.docs[randomIndex];
        setState(() {
          _quote = randomDoc['quote'];
          _author = randomDoc['author'];
        });
      }
    } catch (e) {
      setState(() {
        _quote =
            "Keep your face always toward the sunshine, and shadows will fall behind you.";
        _author = "Walt Whitman";
      });
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4169E1),
        elevation: 0,
        title: const Text(
          'Mindfulness',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Quote",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      _quote,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- $_author",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4169E1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              OptionButton(
                icon: Icons.sentiment_very_satisfied,
                text: 'Make me happy',
                onPressed: () {
                  // Add your onPressed functionality here
                },
              ),
              OptionButton(
                icon: Icons.star,
                text: 'Make me proud',
                onPressed: () {
                  // Add your onPressed functionality here
                },
              ),
              OptionButton(
                icon: Icons.emoji_emotions,
                text: 'Check my mood',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StressQuestionsPage()));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const OptionButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF4169E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          shadowColor: Colors.grey.withOpacity(0.3),
          elevation: 5,
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/mindfulness/Mood_check.dart';

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
        _author = "Walt Whitma";
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mindfulness',
          style: TextStyle(color: Color(0xFF4169E1)),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Quote",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    _quote,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    _author,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4169E1),
        unselectedItemColor: Colors.black,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40, color: Color(0xFF4169E1)),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.blue.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }
}

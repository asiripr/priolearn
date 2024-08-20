import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';

class MakeHappy extends StatefulWidget {
  const MakeHappy({super.key});

  @override
  State<MakeHappy> createState() => _MakeHappyState();
}

class _MakeHappyState extends State<MakeHappy> {
  String? personalizedMessage;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomAnswer();
  }

  Future<void> fetchRandomAnswer() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final currentUserId = user!.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('favorations')
          .where('userId', isEqualTo: currentUserId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final document = querySnapshot.docs.first;
        List<dynamic> answers = document['answers'];
        if (answers.isNotEmpty) {
          final randomIndex = Random().nextInt(answers.length);
          Map<String, dynamic> randomAnswer = answers[randomIndex];

          setState(() {
            personalizedMessage = _getPersonalizedMessage(randomAnswer);
          });
        } else {
          print('no answers found in the document');
        }
      } else {
        print('no matching document found');
      }
    } catch (e) {
      print('error occured');
    }
  }

  String _getPersonalizedMessage(Map<String, dynamic> randomAnswer){
    String answer = randomAnswer['answer'];
    String question = randomAnswer['question'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Be Happy', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            personalizedMessage!,
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
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

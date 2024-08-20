import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MakeHappy extends StatefulWidget {
  const MakeHappy({super.key});

  @override
  State<MakeHappy> createState() => _MakeHappyState();
}

class _MakeHappyState extends State<MakeHappy> {
  Map<String, dynamic>? randomAnswer;

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
          setState(() {
            randomAnswer = answers[randomIndex];
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

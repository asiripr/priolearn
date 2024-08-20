import 'dart:math';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';

class MakeHappy extends StatefulWidget {
  final List<String> suggestions;
  const MakeHappy({super.key, required this.suggestions});

  @override
  _MakeHappyState createState() => _MakeHappyState();
}

class _MakeHappyState extends State<MakeHappy> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomSuggestion = widget.suggestions[random.nextInt(widget.suggestions.length)];
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
            randomSuggestion,
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

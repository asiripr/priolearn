import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Remove top background color
        elevation: 0, // Remove shadow
        title: const Text(
          "About",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PrioLearn",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4169E1), // Royal blue color for PrioLearn
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Stressed Sri Lankan AL Students?",
              style: TextStyle(
                  fontFamily: 'Arial', fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "WE GOT YOU!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Struggling to manage deadlines and your workload?",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              "Feeling overwhelmed by the pressure of Advanced Levels?",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Introducing PrioLearn, your one-stop app for Sri Lankan AL success!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1)), // Royal blue color
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "We help you track assignments, exams and stay on top of your schedule.",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              "Get personalized study suggestions and stress-busting tips tailored for YOU.",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

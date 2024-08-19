import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue for the title
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent, // Remove top background color
        elevation: 0, // Remove shadow
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Feel free to reach out to us.",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF4169E1), // Royal blue color
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "General Inquiries:",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  "Gmail: info@priolearn.com",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  "Telephone: +94 123 4567",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "Technical Support:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  "Gmail: support@priolearn.com",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  "Telephone: +94 123 4567",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "Feedback and Suggestions:",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Share Your Thoughts with Us...",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              "feedback@priolearn.com",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              "Address: PrioLearn Headquarters",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

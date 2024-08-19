import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent, // Remove top background color
        elevation: 0, // Remove shadow
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "At PrioLearn, we are committed to providing the best support to ensure a seamless experience for our users. If you encounter any technical issues, have questions, or need assistance with the app, our support team is here to help.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "Phone Support",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1), // Royal blue color
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Call Us: 0770000000",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Our support team is available during business hours to address your concerns.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "Email Support",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1), // Royal blue color
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Email Us: priolearn@example.com",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "We strive to respond to all inquiries within 24 hours. Please include detailed information about your issue to help us assist you more effectively. Feel free to contact us with any feedback or suggestions you may have to improve your experience with PrioLearn. Your satisfaction is our priority.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

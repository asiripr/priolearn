import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONTACT US"),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the left
          children: [
            SizedBox(height: 20), // Add some space at the top if needed
            Text(
              "Feel free to reach out to us.",
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 31, 9, 228),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "General Inquiries:", // Corrected typo in "Inquiries"
              textAlign: TextAlign
                  .left, // This is actually redundant with the crossAxisAlignment
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 2, 1, 16),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            Icon(
              Icons.mail,
              color: Colors.black,
            ),
            Text("Gmail: info@priolearn.com"),
            Icon(
              Icons.call,
              color: Colors.black,
            ),
            Text("Telephone: +94 123 4567"),
            SizedBox(
              height: 25,
            ),
            Text(
              "Technical Support:", // Corrected typo in "Inquiries"
              textAlign: TextAlign
                  .left, // This is actually redundant with the crossAxisAlignment
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 1, 16),
              ),
            ),
            Icon(
              Icons.mail,
              color: Colors.black,
            ),
            Text("Gmail: info@priolearn.com"),
            Icon(
              Icons.call,
              color: Colors.black,
            ),
            Text("Telephone: +94 123 4567"),
            SizedBox(
              height: 25,
            ),
            Text(
              "Feedbacks and Suggesions:", // Corrected typo in "Inquiries"
              textAlign: TextAlign
                  .left, // This is actually redundant with the crossAxisAlignment
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 2, 1, 16),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Share Your Thoughts with Us..."),
            Text("feedback@peiolearn.com"),
            Text("Address: Priolearn Headquatrers"),
            Icon(
              Icons.call,
              color: Colors.black,
              size: 10,
            ),
          ],
        ),
      ),
    );
  }
}

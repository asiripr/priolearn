import 'package:flutter/material.dart';

class SaveAL extends StatelessWidget {
  const SaveAL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PrioLearn",
      home: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 40, right: 40),
              child: Text(
                "According to the \ninformation you have \ngiven, you are \nscheduled to face the \nAL examination for the \nN time in YYYY.",
                style: TextStyle(fontSize: 30, fontFamily: 'Inter'),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(259, 67),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Go Home",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(259, 67),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Guide Me",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

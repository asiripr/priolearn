import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/button_white.dart';

class SelectSubject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Academics',
          style: TextStyle(
              color: Color.fromARGB(255, 7, 4, 227),
              fontSize: 33,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'You have completed 38% from whole journey...',
                      style: TextStyle(
                          color: Color.fromARGB(255, 7, 4, 227),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: 0.38,
                      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 7, 4, 227)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Select a subject for save details...',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            subjectButton(context, "Physics", (){}),
            subjectButton(context, "Chemistry", (){}),
            subjectButton(context, "Applied", (){}),
            subjectButton(context, "Pure", (){}),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 7, 4, 227),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: '',
          ),
        ],
        currentIndex: 0, // set the initial selected index
        onTap: (int index) {
          // handle navigation logic here
        },
      ),
    );
  }
}

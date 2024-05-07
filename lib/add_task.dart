import 'package:flutter/material.dart';

void main() {
  runApp(AddTask());
}

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);

  int _selectedItem = 0; // Placeholder for selected item index

  void _onItemTapped(int index) {
    // Placeholder for item tap handler
    // You can implement the logic for handling item taps here
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PrioLearn",
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, right: 250),
              child: Text(
                "Add Task",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Note',
                  hintText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Time',
                  hintText: "",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 140),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 67),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Create Task",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        // Design the bottom app bar
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue[300],
          currentIndex: _selectedItem,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: 'Academic',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement),
              label: 'Mindfulness',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:group_13_priolearn/academic/select_subject.dart';
import 'package:group_13_priolearn/mindfulness/mindfulness_screen.dart';
import 'package:group_13_priolearn/pages/new_home.dart';

class MyBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Academic',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: 'Mindfulness',
        ),
      ],
      currentIndex: widget.currentIndex, // set the initial selected index
      onTap: (int index) {
        widget.onTap(index);
        setState(() {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewHome()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectSubject()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MindfulnessScreen()));
              break;
            default:
              index = 0;
          }
        });
      },
    );
  }
}

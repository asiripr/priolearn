import 'package:flutter/material.dart';
import 'package:group_13_priolearn/mindfulness/mood_check.dart';
import 'package:group_13_priolearn/utils/colors.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}
// create valribles for save up to now days and achievements
double myProgress = 0.3;
List<String> achievements = ["I've completed Physics 2013 3rd essay question", "I've completed Physics 2013 3rd essay question", "I've completed Physics 2013 3rd essay question", "I've completed Physics 2013 3rd essay question"]; // in here I've assigned some dummy data

class _NewHomeState extends State<NewHome> {
  // declare a variable for bottom app bar selected item
  int _selectedItem = 0;
  // declare a function for bottom app bar item selection
  void _onItemTapped(int index){
    setState(() {
      _selectedItem = index;
    });
    switch (index) {
      case 0:
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>NewHome()));
        break;
      case 2:
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>StressQuestionsPage()));
        break;
      default:
       index=0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("PrioLearn", style: TextStyle(color: Colors.blue,),)),
          ),
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _drawyerItem("To Do List"),
                _drawyerItem("Reduce Stress"),
                _drawyerItem("Make a Plan"),
                _drawyerItem("Invite Friends"),
                _drawyerItem("About App"),
                _drawyerItem("Contact Us"),
                _drawyerItem("Terms and Conditions"),
                _drawyerItem("App Settings"),
              ],
            ),
          ),
        ),

        // design the bottom app bar
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.blue[300],
        //   currentIndex: _selectedItem,
        //   onTap: _onItemTapped,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home' 
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.menu_book_sharp),
        //       label: 'Academic' 
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.self_improvement),
        //       label: 'Mindfulness' 
        //     ),
        //   ]
        //   ),
        bottomNavigationBar: MoltenBottomNavigationBar(
          
          selectedIndex: _selectedItem,
          onTabChange: (clickedIndex) {
            setState(() {
              _selectedItem = clickedIndex;
            });
          },
          tabs: [
            MoltenTab(
              icon: Icon(Icons.home),
            ),
            MoltenTab(
              icon: Icon(Icons.menu_book_sharp),
            ),
            MoltenTab(
              icon: Icon(Icons.self_improvement),
            ),
          ],
        ),
        // Adding 2 images into the screen
        body: Column(
          children: [
            Text("Up to now you have completed ${myProgress * 100}% from your journey.", style: TextStyle(fontSize: 20),),
            const SizedBox(height: 30,),
            LinearProgressIndicator(
              value: myProgress,
              color: backgroundColor1,
              backgroundColor: backgroundColor2,
              minHeight: 10,
            ),
                          
            // great works card list
            SizedBox(height: 30,),
            Text("My great works"),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(achievements[index])),
                      ),
                  );
                },
              ),
            ),
            SizedBox(height: 30,),
            Text("Quick Actions"),
            
          ],
        )
      ),
    );
  }
}

// make a common widget for drawyer items
Widget _drawyerItem(String title){
  return ListTile(
    title: Text(title),
    onTap: (){},
  );
}

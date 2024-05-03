
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // declare a variable for bottom app bar selected item
  int _selectedItem = 0;
  // declare a function for bottom app bar item selection
  void _onItemTapped(int index){
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                ListTile(
                  title: const Text("To Do List"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Reduce Stress"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Make a Plan"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Invite Friends"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("About App"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Contact Us"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Terms and Conditions"),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("App Settings"),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),

        // design the bottom app bar
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue[300],
          currentIndex: _selectedItem,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home' 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: 'Academic' 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement),
              label: 'Mindfulness' 
            ),
          ]
          ),
        
        // Adding 2 images into the screen
        body: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.075,
              left: -screenWidth * 0.1,
              child: Opacity(
                opacity: 0.5, 
                child: Image.asset(
                  "assets/image-3.png", 
                  height: 200, 
                  width: 200,
                 )
              )
            ),
            Positioned(
              top: screenHeight * 0.1,
              right: -screenWidth * 0.075,
              child: Opacity(
                opacity: 0.5, 
                child: Image.asset(
                  "assets/image-4.png", 
                  height: 100, 
                  width: 100,
                 )
              )
            ),
            // Positioned(
            //   top: screenHeight*0.03,
            //   left: 0,
            //   right: 0,
            //   child: Column(
            //     children: [
            //       Text("Great works in last week..."),

            //       // greate works list
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ListTile(
            //           title: Text("I attended to the physics lecture"),
            //           tileColor: Colors.blue.shade300,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ListTile(
            //           title: Text("I Completed 30 Chemistry MCQ in 2018 paper."),
            //           tileColor: Colors.green.shade300,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ListTile(
            //           title: Text("I could be able to complete attend a Pure mathematics seminar"),
            //           tileColor: Colors.orange.shade300,
            //         ),
            //       ),

            //       // see more button
            //       ElevatedButton(
            //         onPressed: (){}, 
            //         child: const Text("See More")),

            //       //menu icons
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Column(
            //           children: [
            //             Row(
            //               children: [
            //                 IconButton(onPressed: (){}, icon: Icon(Icons.auto_graph,size: 100,)),
            //                 //SizedBox(width: screenWidth *0.3,),
            //                 IconButton(onPressed: (){}, icon: Icon(Icons.save_as_outlined, size: 100,)),
            //               ],
            //             ),
            //             SizedBox( height: 20,),
            //             Row(
            //               children: [
            //                 IconButton(onPressed: (){}, icon: Icon(Icons.tag_faces_sharp, size: 100,)),
            //                 //SizedBox(width: screenWidth *0.3,),
            //                 IconButton(onPressed: (){}, icon: Icon(Icons.sports_handball_outlined, size: 100,)),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ), 
            //   ],),
            //) 
          ],
        ),
        
      ),
    );
  }
}
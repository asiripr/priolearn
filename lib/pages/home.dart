import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("PrioLearn", style: TextStyle(color: Colors.blue,),)),
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
                  title: const Text("App Settings"),
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
                  title: const Text("Settings"),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}
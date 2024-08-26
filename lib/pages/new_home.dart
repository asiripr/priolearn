import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/academic/choose_lesson.dart';
import 'package:group_13_priolearn/academic/select_subject.dart';
import 'package:group_13_priolearn/activities/activities.dart';
import 'package:group_13_priolearn/mindfulness/mindfulness_screen.dart';
import 'package:group_13_priolearn/mindfulness/mood_check.dart';
import 'package:group_13_priolearn/pages/great_works.dart';
import 'package:group_13_priolearn/progress/main_bar_graph.dart';
import 'package:group_13_priolearn/progress/show_progress.dart';
import 'package:group_13_priolearn/settings/about.dart';
import 'package:group_13_priolearn/pages/contact.dart';
import 'package:group_13_priolearn/settings/account.dart';
import 'package:group_13_priolearn/to_do/to_do.dart';
import 'package:group_13_priolearn/to_do/to_do_calendar.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';
import 'package:group_13_priolearn/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  DateTime get _startOfWeek {
    final DateTime now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  DateTime get _endOfWeek {
    final DateTime now = DateTime.now();
    return now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _totalMinutes = 0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "PrioLearn",
            style: TextStyle(
              color: Color(0xFF4169E1), // Royal blue color
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF4169E1),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              _drawerItem(Icons.check_circle, "To-Do List", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ToDoHome()));
              }),
              _drawerItem(Icons.spa, "Reduce Stress", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MindfulnessScreen()));
              }),
              _drawerItem(Icons.info, "About App", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              }),
              _drawerItem(Icons.contact_mail, "Contact Us", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Contact()));
              }),
              _drawerItem(Icons.description, "Terms and Conditions", () {
                // Implement navigation to Terms and Conditions page
              }),
              _drawerItem(Icons.settings, "App Settings", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              }),
            ],

          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Total learning time
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('tasks')
                      .where('type', isEqualTo: 'Academic')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      var items = snapshot.data!.docs;
                      _totalMinutes = 0;
                      for (var item in items) {
                        dynamic dateData = item['date'];
                        DateTime date = DateTime.now();

                        if (dateData is Timestamp) {
                          date = dateData.toDate();
                        } else if (dateData is String) {
                          date = DateTime.parse(dateData);
                        }

                        if (date.isAfter(_startOfWeek) &&
                            date.isBefore(_endOfWeek)) {
                          _totalMinutes += item['duration'] as int;
                        }
                      }
                      return Card(
                        margin: EdgeInsets.all(10),
                        color: Color(0xFF87CEFA), // Light blue background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "In the past 7 days, you have spent\n${_totalMinutes} mins\non your academics",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                // Quick Actions section
                _sectionTitle("Quick Actions"),
                Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  children: [
                    _quickActionButtonCard("To-Do", "assets/image-50.png", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ToDo()));
                    }),
                    _quickActionButtonCard("Academic", "assets/image-51.png",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectSubject()));
                    }),
                    _quickActionButtonCard("Mindfulness", "assets/image-52.png",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MindfulnessScreen()));
                    }),
                    _quickActionButtonCard("Progress", "assets/image-53.png",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowProgress()));
                    }),
                  ],
                ),
                SizedBox(height: 30),
                // Great Works section
                _sectionTitle("My Great Works", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GreatWorks()));
                }),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('done_list')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No data available'));
                    }

                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length > 3 ? 3 : documents.length,
                      itemBuilder: (context, index) {
                        final data =
                            documents[index].data() as Map<String, dynamic>;
                        final competency = data['competency'] ?? '';
                        final createdAt = data['createdAt'] ?? Timestamp.now();
                        final lesson = data['lesson'] ?? '';
                        final subjectName = data['subjectName'] ?? '';
                        final taskType = data['taskType'] ?? '';
                        final formattedDate =
                            DateFormat('MMMM d, y').format(createdAt.toDate());

                        final sentence =
                            'I completed a $taskType on "$lesson" in $subjectName, marked with competency level $competency, on $formattedDate.';

                        return Card(
                          color: Colors.blue.shade100,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              sentence,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        );
                      },
                    );
                  },

                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

// Drawer item widget
Widget _drawerItem(IconData icon, String title, Function onTap) {

  return ListTile(
    leading: Icon(icon, color: Color(0xFF4169E1)),
    title: Text(title),
    onTap: () {
      onTap();
    },
  );
}

// Section title widget with optional action
Widget _sectionTitle(String title, [Function? action]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (action != null)
          TextButton(
            onPressed: () {
              action();
            },
            child: const Text(
              "See All",
              style: TextStyle(color: Color(0xFF4169E1)),

            ),
          ),
      ],
    ),
  );
}
// Quick Action Button Card widget
Widget _quickActionButtonCard(String title, String imagePath, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: SizedBox(
      width: 150,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


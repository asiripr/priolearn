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

  // get the start of the week
  DateTime get _startOfWeek {
    final DateTime now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  //get the end of the week
  DateTime get _endOfWeek {
    final DateTime now = DateTime.now();
    return now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  }

  @override
  Widget build(BuildContext context) {
    int _totalMinutes;
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "PrioLearn",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _drawerItem("To Do List", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ToDoHome(),
                      ));
                }),
                _drawerItem("Reduce Stress", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MindfulnessScreen(),
                      ));
                }),
                _drawerItem("About App", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About(),
                      ));
                }),
                _drawerItem("Contact Us", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ));
                }),
                _drawerItem("Terms and Conditions", () {}),
                _drawerItem("App Settings", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Account(),
                      ));
                }),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Display total learning time
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
                        return Container(
                          width: size.width,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            color: Colors.lightBlue.shade100,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    "In past 7 days, you have spent\n${_totalMinutes} mins\non your academics",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),

                // Great works card list
                SizedBox(height: 20),
                SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Great Works", style: TextStyle(fontSize: 20)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GreatWorks(),
                                ));
                          },
                          child: Text("See All"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // StreamBuilder for Great Works
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('done_list')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error loading data'));
                        }
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No data available'));
                        }

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;

                        return SizedBox(
                          height: 250, // Adjust height as needed
                          child: ListView.builder(
                            itemCount: documents.length > 3
                                ? 3
                                : documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = documents[index].data()
                                  as Map<String, dynamic>;
                              final String competency =
                                  data['competency'] ?? '';
                              final Timestamp createdAt =
                                  data['createdAt'] ?? Timestamp.now();
                              final String lesson = data['lesson'] ?? '';
                              final String subjectName =
                                  data['subjectName'] ?? '';
                              final String taskType = data['taskType'] ?? '';

                              final formattedDate = DateFormat('MMMM d, y')
                                  .format(createdAt.toDate());
                              final String sentence =
                                  'I completed a $taskType on "$lesson" in $subjectName, marked with competency level $competency, on $formattedDate.';

                              return Card(
                                color: Colors.lightBlue.shade100,
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    sentence,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 20),
                ),
                Wrap(
                  spacing: 35,
                  runSpacing: 35,
                  children: [
                    _quickActionButtonCard("To-Do", "assets/image-50.png", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToDo(),
                          ));
                    }),
                    _quickActionButtonCard("Academic", "assets/image-51.png",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectSubject(),
                          ));
                    }),
                    _quickActionButtonCard(
                        "Mindfulness", "assets/image-52.png", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MindfulnessScreen(),
                          ));
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

// create a common widget for drawer items
Widget _drawerItem(String title, Function myFunction) {
  return ListTile(
    title: Text(title),
    onTap: () {
      myFunction();
    },
  );
}

// create a common widget for quick action menu button
Widget _quickActionButtonCard(
    String menuName, String imagePath, Function myFunction) {
  return Card(
    child: InkWell(
      onTap: () {
        myFunction();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              height: 120,
            ),
          ),
          Text(menuName)
        ],
      ),
    ),
  );
}

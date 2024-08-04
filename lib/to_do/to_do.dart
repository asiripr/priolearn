import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/to_do/add_task.dart';
import 'package:group_13_priolearn/to_do/to_do_calendar.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  int _totalMinutes = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ------ display total learning time -------
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('type', isEqualTo: 'Academic')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
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

                      if (isSameDay(date, _selectedDate)) {
                        _totalMinutes += item['duration'] as int;
                      }
                    }

                    int hours = _totalMinutes ~/ 60;
                    int minutes = _totalMinutes % 60;

                    return Container(
                      width: size.width,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.blue.shade100,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "You have\n${hours} hrs and ${minutes} mins\nto learn",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Text("Previous"),
            // ------------------ list of previous tasks ------------------
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  var items = snapshot.data!.docs;
                  var filteredItems = items.where((item) {
                    dynamic dateData = item['date'];
                    DateTime date = DateTime.now();

                    if (dateData is Timestamp) {
                      date = dateData.toDate();
                    } else if (dateData is String) {
                      date = DateTime.parse(dateData);
                    }

                    // Filter tasks that are before today
                    DateTime today = DateTime.now();
                    return date
                        .isBefore(DateTime(today.year, today.month, today.day));
                  }).toList();
                  return SizedBox(
                    height: 200, // Set the height as needed
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = filteredItems[index];
                        dynamic dateData = item['date'];
                        DateTime date = DateTime.now();

                        if (dateData is Timestamp) {
                          date = dateData.toDate();
                        } else if (dateData is String) {
                          date = DateTime.parse(dateData);
                        }
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Checkbox(
                              value: item['isDone'],
                              onChanged: (bool? value) async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(item.id)
                                    .update({'isDone': value});
                              },
                            ),
                            title: Text(
                              item['title'],
                              style: TextStyle(
                                decoration: item['isDone']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            // -----------------------------------------------------------
            const Text("Today"),
            // ------------------ list of today tasks --------------------
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  var items = snapshot.data!.docs;
                  var filteredItems = items.where((item) {
                    dynamic dateData = item['date'];
                    DateTime date = DateTime.now();

                    if (dateData is Timestamp) {
                      date = dateData.toDate();
                    } else if (dateData is String) {
                      date = DateTime.parse(dateData);
                    }

                    // Filter tasks that are on today
                    return isSameDay(date, _selectedDate);
                  }).toList();
                  return SizedBox(
                    height: 200, // Set the height as needed
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = filteredItems[index];
                        dynamic dateData = item['date'];
                        DateTime date = DateTime.now();

                        if (dateData is Timestamp) {
                          date = dateData.toDate();
                        } else if (dateData is String) {
                          date = DateTime.parse(dateData);
                        }
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Checkbox(
                              value: item['isDone'],
                              onChanged: (bool? value) async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(item.id)
                                    .update({'isDone': value});
                              },
                            ),
                            title: Text(
                              item['title'],
                              style: TextStyle(
                                decoration: item['isDone']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            // -----------------------------------------------------------
            const Text("Future"),
            // ------------------ list of future tasks -------------------
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  var items = snapshot.data!.docs;
                  var filteredItems = items.where((item) {
                    dynamic dateData = item['date'];
                    DateTime date = DateTime.now();

                    if (dateData is Timestamp) {
                      date = dateData.toDate();
                    } else if (dateData is String) {
                      date = DateTime.parse(dateData);
                    }

                    // Filter tasks that are after today
                    DateTime today = DateTime.now();
                    return date
                        .isAfter(DateTime(today.year, today.month, today.day));
                  }).toList();
                  return SizedBox(
                    height: 200, // Set the height as needed
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = filteredItems[index];
                        dynamic dateData = item['date'];
                        DateTime date = DateTime.now();

                        if (dateData is Timestamp) {
                          date = dateData.toDate();
                        } else if (dateData is String) {
                          date = DateTime.parse(dateData);
                        }
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Checkbox(
                              value: item['isDone'],
                              onChanged: (bool? value) async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(item.id)
                                    .update({'isDone': value});
                              },
                            ),
                            title: Text(
                              item['title'],
                              style: TextStyle(
                                decoration: item['isDone']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            // -----------------------------------------------------------
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoHome(),
                  ));
            },
            child: Icon(Icons.calendar_month),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(),
                  ));
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

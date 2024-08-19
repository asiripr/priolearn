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

  int _totalMinutes = 0;
  DateTime _selectedDate = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To Do",

          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Color(0xFF4169E1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ------ Display total learning time -------
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where('type', isEqualTo: 'Academic')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var items = snapshot.data!.docs;
                  _totalMinutes = 0;
                  for (var item in items) {
                    dynamic dateData = item['date'];
                    DateTime date = DateTime.now();

            //const SizedBox(height: 20),


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
                              "You have\n${hours} hrs and ${minutes} mins\nof learning today",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Previous Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // List of previous tasks
            _buildTaskList(context, 'Previous', (DateTime date) => date.isBefore(DateTime.now())),
            const SizedBox(height: 20),
            Text(
              "Today's Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // List of today's tasks
            _buildTaskList(context, 'Today', (DateTime date) => isSameDay(date, _selectedDate)),
            const SizedBox(height: 20),
            Text(
              "Future Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // List of future tasks
            _buildTaskList(context, 'Future', (DateTime date) => date.isAfter(DateTime.now())),
          ],
        ),
      ),
      floatingActionButton: Column(
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
          const SizedBox(height: 16),
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
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, String label, bool Function(DateTime) dateCondition) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
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

            return dateCondition(date);
          }).toList();

          return ListView.builder(
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
                      decoration: item['isDone'] ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  // Task List Builder
  Widget _buildTaskListSection({required bool Function(DateTime) filter}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var items = snapshot.data!.docs;
        var filteredItems = items.where((item) {
          DateTime date = _extractDate(item['date']);
          return filter(date);
        }).toList();

        if (filteredItems.isEmpty) {
          return const Center(child: Text("No tasks available"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredItems.length,
          itemBuilder: (BuildContext context, int index) {
            var item = filteredItems[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                    fontSize: 18,
                  ),
                ),
                subtitle:
                    Text(DateFormat.yMMMd().format(_extractDate(item['date']))),
              ),
            );
          },
        );
      },
    );
  }

  // Extract Date from Firebase Firestore Data
  DateTime _extractDate(dynamic dateData) {
    if (dateData is Timestamp) {
      return dateData.toDate();
    } else if (dateData is String) {
      return DateTime.parse(dateData);
    }
    return DateTime.now();
  }
}

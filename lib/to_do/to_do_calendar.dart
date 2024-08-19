import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/to_do/add_task.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  int _totalMinutes = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My To-Do List",
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Flat design
        iconTheme: IconThemeData(color: Color(0xFF4169E1)), // Icon color
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime.utc(2024, 01, 01),
            lastDay: DateTime.utc(2034, 01, 01),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xFF4169E1),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                    color: Colors.lightBlue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "You have\n${hours} hrs and ${minutes} mins\nto learn",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4169E1),
                            ),
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('tasks').snapshots(),
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

                    return isSameDay(date, _selectedDate);
                  }).toList();

                  return ListView.builder(
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
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
                          subtitle: Text(
                            '${DateFormat('yyyy-MM-dd').format(date)}\n${item['note']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddTask(
                                        task: item,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF4169E1),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(item.id)
                                      .delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Task deleted successfully.")),
                                  );
                                },
                                icon:
                                    Icon(Icons.delete, color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        backgroundColor: Color(0xFF4169E1), // Royal blue color
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          MyBottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/to_do/add_task.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To Do"),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate, 
            firstDay: DateTime.utc(2024,01,01), 
            lastDay: DateTime.utc(2034,01,01),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format){
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
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }else{
                  var items = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = items[index];
                      dynamic dateData = item['date'];
                      DateTime date = DateTime.now();
                      
                      if (dateData is Timestamp) {
                        date = dateData.toDate();
                      }else if(dateData is String){
                        date = DateTime.parse(dateData);
                      }

                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(item['title']),
                          subtitle: Text('${DateFormat('yyyy-MM-dd').format(date)}\n${item['note']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => AddTask(task: item,),));
                                }, 
                                icon: Icon(Icons.edit)
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance.collection('tasks').doc(item.id).delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Task deleted successfully."))
                                  );
                                }, 
                                icon: Icon(Icons.delete)
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => AddTask(),));
        },
        child: const Icon(Icons.add)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle navigation to different screens
        },
      ),
    );
  }
}
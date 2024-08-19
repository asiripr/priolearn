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
  DateTime _selectedDate = DateTime.now();
  int _totalMinutes = 0;

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
          style: TextStyle(
            color: Color(0xFF4169E1), // Royal blue color for the title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display total learning time
            _buildTotalLearningTimeCard(size),

            const SizedBox(height: 20),

            _buildSectionHeader("Previous Tasks"),
            _buildTaskListSection(
                filter: (date) => date.isBefore(_selectedDate)),

            const SizedBox(height: 20),

            _buildSectionHeader("Today's Tasks"),
            _buildTaskListSection(
                filter: (date) => isSameDay(date, _selectedDate)),

            const SizedBox(height: 20),

            _buildSectionHeader("Future Tasks"),
            _buildTaskListSection(
                filter: (date) => date.isAfter(_selectedDate)),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
      bottomNavigationBar:
          MyBottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }

  // Floating Action Buttons
  Row _buildFloatingActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'calendarBtn',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToDoHome(),
                ));
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.calendar_month),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'addTaskBtn',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTask(),
                ));
          },
          backgroundColor: Colors.greenAccent,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  // Section Header Builder
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // Total Learning Time Card
  Widget _buildTotalLearningTimeCard(Size size) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('type', isEqualTo: 'Academic')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var items = snapshot.data!.docs;
        _totalMinutes = 0;
        for (var item in items) {
          DateTime date = _extractDate(item['date']);
          if (isSameDay(date, _selectedDate)) {
            _totalMinutes += item['duration'] as int;
          }
        }

        int hours = _totalMinutes ~/ 60;
        int minutes = _totalMinutes % 60;

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          color: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Total Learning Time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "${hours} hrs and ${minutes} mins",
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:group_13_priolearn/utils/text_field.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  final DocumentSnapshot? task;
  const AddTask({super.key, this.task});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _STimeController = TextEditingController();
  final TextEditingController _ETimeController = TextEditingController();

  List<String> dropDownValues = ["Academic", "Other"];
  String? dropDownValue = "Academic";
  @override
  void initState() {
    super.initState();
    if (widget.task!=null) {
      _titleController.text = widget.task!['title'];
      _dateController.text = DateFormat('yyyy-MM-dd').format((widget.task!['date'] as Timestamp).toDate());
      _noteController.text = widget.task!['note'];
      _STimeController.text = widget.task!['STime'];
      _ETimeController.text = widget.task!['ETime'];
      final int totalTime = widget.task!['allocatedTime'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task"),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            myTextField("Title", _titleController, false),
            const SizedBox(height: 20,),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ),
              onTap: () async{
                DateTime? pickedDate = await showDatePicker(
                  context: context, 
                  firstDate: DateTime.now(), 
                  lastDate:DateTime(2030),
                  initialDate: DateTime.now(), 
                );
                if (pickedDate!=null) {
                  String formattedDate = DateFormat('yyy-MM-dd').format(pickedDate);
                  setState(() {
                    _dateController.text = formattedDate;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            myTextField("Note", _noteController, false),
            const SizedBox(height: 20),
            TextField(
              controller: _STimeController,
              decoration: const InputDecoration(
                labelText: "Start Time",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                )
              ),
              onTap: ()async{
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context, 
                  initialTime: TimeOfDay.now()
                );
                if (pickedTime!=null) {
                  final now = DateTime.now();
                  final dt = DateTime(now.year, now.month, now.day,  pickedTime.hour, pickedTime.minute);
                  String formattedTime = DateFormat('HH:mm').format(dt);
                  setState(() {
                    _STimeController.text = formattedTime;
                  });
                }
              },
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _ETimeController,
              decoration: const InputDecoration(
                labelText: "End Time",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                )
              ),
              onTap: ()async{
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context, 
                  initialTime: TimeOfDay.now()
                );
                if (pickedTime!=null) {
                  final now = DateTime.now();
                  final dt = DateTime(now.year, now.month, now.day,  pickedTime.hour, pickedTime.minute);
                  String formattedTime = DateFormat('HH:mm').format(dt);
                  setState(() {
                    _ETimeController.text = formattedTime;
                  });
                }
              },
            ),
            const SizedBox(height: 20,),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Task Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ),
              value: dropDownValue,
              onChanged: (String? value){
                setState(() {
                  dropDownValue = value;
                });
              },
              items: dropDownValues.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem(
                  value: value,
                  child: Text(value)
                );
              }).toList(), 
            ),
            const SizedBox(height: 20),
            // button
          ],
        ),
      ),
    );
  }
  Future<void> saveTask() async{
    final String title = _titleController.text;
    final String date = _dateController.text;
    final String note = _noteController.text;
    final String STime = _STimeController.text;
    final String ETime = _ETimeController.text;
    final String type = dropDownValue!;

    if (title.isNotEmpty && date.isNotEmpty && STime.isNotEmpty) {
      final taskData = {
        'title':title,
        'date':Timestamp.fromDate(DateFormat('yyy-MM-dd').parse(date)),
        'note':note,
        'STime':STime,
        'Etime':ETime,
        'type':type,
        'createdAt':Timestamp.now()
      };
      if(widget.task!=null){
        await FirebaseFirestore.instance.collection('tasks').doc(widget.task!.id).update(taskData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task updated successfully"))
        );
      }else{
        await FirebaseFirestore.instance.collection('tasks').add(taskData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task created successfully')),
        );
      }
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context)=>ToDoHome())
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }
}
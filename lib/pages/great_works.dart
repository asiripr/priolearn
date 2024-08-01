import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreatWorks extends StatefulWidget {
  const GreatWorks({super.key});

  @override
  State<GreatWorks> createState() => _GreatWorksState();
}

class _GreatWorksState extends State<GreatWorks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Great Works"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('done_list').snapshots(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);            
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));            
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final data = documents[index].data() as Map<String, dynamic>;
              final String competency = data['competency'] ?? '';
              final Timestamp createdAt = data['createdAt'] ?? Timestamp.now();
              final String lesson = data['lesson'] ?? '';
              final String subjectName = data['subjectName'] ?? '';
              final String taskType = data['taskType'] ?? '';

              final formattedDate = DateFormat('MMMM d, y').format(createdAt.toDate());

              final String sentence = 'I completed a $taskType on "$lesson" in $subjectName, marked with competency level $competency, on $formattedDate.';

              return Card(
                color: Colors.lightBlue.shade400,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    sentence,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
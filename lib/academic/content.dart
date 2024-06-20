import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String lessonId;
  final int competencyIndex;
  const Content({super.key, required this.lessonId, required this.competencyIndex});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<dynamic>? content;
  @override
  void initState() {
    super.initState();
    fetchContent();
  }
  Future<void> fetchContent() async{  
    final lessonDoc = await FirebaseFirestore.instance.collection('physics').doc(widget.lessonId).get();
    List competenciesList = lessonDoc['competencies'];
    setState(() {
      content = competenciesList[widget.competencyIndex]['content'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Content"),),
      body: Column(
        children: [
          content==null?const CircularProgressIndicator():
          Column(
            children: [
              const Text("This is the content for selected part:"),
              const SizedBox(height: 20),
              ...content!.map((item) => Text(item.toString())).toList(),
            ],
          )
        ],
      ),
    );
  }
}
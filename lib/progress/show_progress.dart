import 'package:flutter/material.dart';
import 'package:group_13_priolearn/progress/main_bar_graph.dart';

class ShowProgress extends StatefulWidget {
  const ShowProgress({super.key});

  @override
  State<ShowProgress> createState() => _ShowProgressState();
}

class _ShowProgressState extends State<ShowProgress> {
  List<double> weeklySummary = [
    54.25,
    28.32,
    52.62,
    63.75,
    85.85,
    31.22,
    37.50
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress"),),
      body: MainBarGraph(weeklySummary: weeklySummary), // replace by my bar graph
    );
  }
}
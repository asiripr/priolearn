import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/progress/bar_data.dart';

class MainBarGraph extends StatefulWidget {
  final List<double> weeklySummary;
  const MainBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  State<MainBarGraph> createState() => _MainBarGraphState();
}

class _MainBarGraphState extends State<MainBarGraph> {
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(sunAmount: widget.weeklySummary[0], monAmount: widget.weeklySummary[1], tueAmount: widget.weeklySummary[2], wedAmount: widget.weeklySummary[3], thuAmount: widget.weeklySummary[4], friAmount: widget.weeklySummary[4], satAmount: widget.weeklySummary[5]);
    myBarData.initializedBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barData.map((data)=>BarChartGroupData(
          x: data.x,
          barRods: [
            BarChartRodData(
              toY: data.y)
          ]
        )).toList()
      )
    );
  }
}
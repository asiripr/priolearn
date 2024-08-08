import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/summary_page.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class Foodpage extends StatefulWidget {
  const Foodpage({super.key});

  @override
  State<Foodpage> createState() => _FoodpageState();
}

class _FoodpageState extends State<Foodpage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Who is your\n food?',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(value: 0.33),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserData>(context, listen: false).updateSinger(_controller.text);
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>SummaryPage()));                
              },
              child: const Text('Next'),
            ),
            Spacer(),
            // bottom app bar
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
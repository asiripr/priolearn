import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/DreamTravelDestinationPage.dart';
import 'package:group_13_priolearn/get_secondary_information/SportPage.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class Hobby extends StatefulWidget {
  const Hobby({super.key});

  @override
  State<Hobby> createState() => _HobbyState();
}

class _HobbyState extends State<Hobby> {
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
              'What is your\n favorite hobby?',
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
            LinearProgressIndicator(value: 0.1428),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserData>(context, listen: false).updateSinger(_controller.text);
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Sportpage()));                
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
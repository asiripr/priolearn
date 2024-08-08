import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/FavoriteSingerPage.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class Sportpage extends StatefulWidget {
  const Sportpage({super.key});

  @override
  State<Sportpage> createState() => _SportpageState();
}

class _SportpageState extends State<Sportpage> {
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
              'Who is your\n favorite sport?',
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
                MaterialPageRoute(builder: (context)=>FavoriteSingerPage()));                
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
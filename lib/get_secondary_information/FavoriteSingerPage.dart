import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/DreamTravelDestinationPage.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class FavoriteSingerPage extends StatefulWidget {
  @override
  _FavoriteSingerPageState createState() => _FavoriteSingerPageState();
}

class _FavoriteSingerPageState extends State<FavoriteSingerPage> {
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
              'Who is your\n favorite singer?',
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
                MaterialPageRoute(builder: (context)=>DreamTravelDestinationPage()));                
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

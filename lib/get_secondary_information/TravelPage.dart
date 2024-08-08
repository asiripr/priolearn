import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/FavoriteMovieTVShowPage.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class Travelpage extends StatefulWidget {
  const Travelpage({super.key});

  @override
  State<Travelpage> createState() => _TravelpageState();
}

class _TravelpageState extends State<Travelpage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Who is your\n dream travel destination?',
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
                MaterialPageRoute(builder: (context)=>FavoriteMovieTVShowPage()));                
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
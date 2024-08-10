import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/user_data.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    void handleSubmit() {
      // Here you can implement your submission logic, such as sending data to a server, saving locally, etc.
      // For demonstration purposes, let's print the data to the console.
      print('Submitting data:');
      print('Hobby: ${userData.hobby}');
      print('Favorite Sport: ${userData.favoriteSport}');
      print('Favorite Singer: ${userData.favoriteSinger}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Here are your answers:'),
            SizedBox(height: 20),
            Text('Hobby: ${userData.hobby}'),
            Text('Favorite Sport: ${userData.favoriteSport}'),
            Text('Favorite Singer: ${userData.favoriteSinger}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  handleSubmit, // Call handleSubmit when button is pressed
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

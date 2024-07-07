import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Settings"),),
      body: Column(
        children: [
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 15,),
                Text('Log Out'),
              ],
            ),
            onTap: () {
              
            },
          ),
          const SizedBox(height: 20,),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 15,),
                Text('Delete Account', style: TextStyle(color: Colors.red),),
              ],
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
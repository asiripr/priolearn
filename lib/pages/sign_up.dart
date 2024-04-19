import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(color: Colors.black, fontSize:45 
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                fillColor: Colors.blue[100],
                labelText: "Username",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 0, 140, 255))
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: Colors.blue[100],
                labelText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 0, 140, 255))
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 0, 140, 255))
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(50.0),
                child: SizedBox(
                  width:double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text("Sign Up",style: TextStyle(fontSize: 30, color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
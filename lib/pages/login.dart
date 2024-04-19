import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({super.key});

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
              "Log In",
              style: TextStyle(color: Colors.black, fontSize:45 
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
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
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
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
                    child: Text("Log In",style: TextStyle(fontSize: 30, color: Colors.black),),
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_13_priolearn/authentication/sign_up.dart';
import 'package:group_13_priolearn/pages/home.dart';
import 'package:group_13_priolearn/utils/colors.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _logIn(BuildContext context) async {
  try {
    // Sign in with email and password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // Check if user exists and email and password are correct
    if (userCredential.user != null) {
      // Navigate to the home screen upon successful sign in
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => Home())
        );
    } else {
      // Handle sign in errors
      print("User account not found or email/password incorrect.");
    }
  } on FirebaseAuthException catch (e) {
    // Handle specific sign in errors
    if (e.code == 'user-not-found') {
      print('No user found with that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      // Handle other FirebaseAuthException errors
      print("Sign in failed: ${e.message}");
    }
  } catch (e) {
    // Handle generic errors
    print("Failed to sign in: $e");
  }
}


  Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              const Text("Log In", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height * 0.04),
              const SizedBox(height: 15,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.blue[100],
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 0, 140, 255))
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red)
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 0, 140, 255))
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red)
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04,),
        
              GestureDetector(
                onTap: () {
                  _logIn(context);
                },
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.07,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.green.shade400),),
                  )],
              )
            ],
          ),
        ),
      ),
    );
  }
}
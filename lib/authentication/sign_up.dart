import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/authentication/login.dart';
import 'package:group_13_priolearn/utils/colors.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if(userCredential.user!=null){
        print("you already have a account");        
      }
      else{
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=> Login())
        );
      }
      // Additional steps after sign up (e.g., user profile setup)
    } 
    on FirebaseAuthException catch(e){
      if (e.code=="auth/email-already-exists") {
        print('the email you entered is already in use by an existing user');
      }
    }
    catch (e) {
      // Handle sign up errors
      print("Failed to sign up: $e");
    }
  }

  SignUp({super.key});

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
              const Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,), ),
              SizedBox(height: size.height * 0.04),
              const SizedBox(height: 15,),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
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
                  _signUp(context);
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
                      "Sign Up",
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
                  const Text("Already have an account? "),
                  GestureDetector(onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text("Log In", style: TextStyle(color: Colors.green.shade400),),
                  )],
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/authentication/login.dart';
import 'package:group_13_priolearn/utils/button.dart';
import 'package:group_13_priolearn/utils/colors.dart';
import 'package:group_13_priolearn/utils/text_field.dart';

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
        // ignore: avoid_print
        print("you already have a account");        
      }
      else{
        // ignore: use_build_context_synchronously
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
              myTextField("username", _usernameController, false),
              const SizedBox(height: 15,),
              myTextField("Email", _emailController, false),
              const SizedBox(height: 15,),
              myTextField("Password", _passwordController, true),
              SizedBox(height: size.height * 0.04,),
        
              myButton(context, "Sign Up", _signUp),
              SizedBox(height: size.height*0.07,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text("Log In", style: TextStyle(color: Colors.blue.shade400),),
                  )],
              )
            ],
          ),
        ),
      ),
    );
  }
}
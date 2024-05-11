import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/button.dart';
import 'package:group_13_priolearn/utils/text_field.dart';

class FogetPassword extends StatefulWidget {
  const FogetPassword ({super.key});

  @override
  State<FogetPassword > createState() => _FogetPasswordState();
}

class _FogetPasswordState extends State<FogetPassword > {
final _emailController = TextEditingController();

@override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  Future _resetPassword() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            myTextField("Email", _emailController, false),
            const SizedBox(height: 15,),
            myButton(context, "Reset Password", _resetPassword as Function(BuildContext p1))
          ],
        ),
      ),
    );
  }
}

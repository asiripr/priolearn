import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/colors.dart';

// my_text_field.dart
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const MyTextField({Key? key, required this.label, required this.controller}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        controller: myController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
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
    );
  }

// create a widget for common text fields    
Container myTextField(String label, TextEditingController myController){
    return Container(
      child: TextField(
                controller: myController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: label,
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
    );
  }

// create a widget for common buttons  
Container myButton(String buttonName, String function){
  return Container(
    child: GestureDetector(
                onTap: () {
                  function(context);
                },
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      buttonName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22
                      ),
                    ),
                  ),
                ),
              ),
  );
}
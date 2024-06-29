// create a widget for subject buttons  
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/colors.dart';

Container subjectButton(BuildContext context, String buttonName, Function() myFunction){
  Size size = MediaQuery.of(context).size;
  return Container(
    child: GestureDetector(
      onTap: () {
        myFunction();
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 20
            ),
          ),
        ),
      ),
    ),
  );
}

// create a widget for common buttons  
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/colors.dart';

Container myButtonVoid(BuildContext context, String buttonName, Function() myFunction, {required Color color}){
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
          color: buttonColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
      ),
    ),
  );
}
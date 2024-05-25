import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/utils/dynamic_button.dart';
import 'package:group_13_priolearn/utils/text_field.dart';

import '../utils/button.dart';

class YearSelector extends StatefulWidget {
  const YearSelector({super.key});

  @override
  State<YearSelector> createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  String? _selectedYear;
  final _yearController = TextEditingController();

  // prepare the list of suitable years.
  List<String> _getYears(){
    final currentYear = DateTime.now().year;
    return [currentYear.toString(), (currentYear+1).toString(), (currentYear+2).toString()];
  } 
  // create the method for choose a year and save it on the firebase
  dynamic _saveYearDB() async{
    if(_selectedYear!=null){
      _yearController.text=_selectedYear!;
      try{
        await FirebaseFirestore.instance.collection('years').add({
          'year':_selectedYear,
          'timestamp':FieldValue.serverTimestamp()
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Year saved successfully'))
        );
      }
      catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Faild to save a year: $e'))
        );
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a year'))
      );
    }
    

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              const Text("What is your AL year?", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height * 0.04),
              const SizedBox(height: 15,),
              // year selection part
              
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Year'
                ),
                items: _getYears().map((year){
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year),
                    );
                }).toList(), 
                value: _selectedYear,
                onChanged: (value){
                  setState(() {
                    _selectedYear = value;
                  });
                }
              ),
              SizedBox(height: 15,),
              myButton(context, "Next", _saveYearDB()),
              SizedBox(height: size.height*0.07,),
  
            ],
          ),
        ),
    );
  }
}
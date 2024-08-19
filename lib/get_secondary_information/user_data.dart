import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String hobby = '';  
  String singer = '';  
  String sport = '';  
  String travel= '';  
  String tvshow= '';  
  String food= '';

  get favoriteSport => null;

  get favoriteSinger => null;  

  void updateHobby(String newHobby){
    hobby = newHobby;
    notifyListeners();
  } 
  void updateSinger(String newSinger){
    hobby = newSinger;
    notifyListeners();
  } 
  void updateSport(String newSport){
    hobby = newSport;
    notifyListeners();
  } 
  void updateTravel(String newTravel){
    hobby = newTravel;
    notifyListeners();
  } 
  void updateTvshow(String newTvshow){
    hobby = newTvshow;
    notifyListeners();
  } 
  void updatefood(String newFood){
    hobby = newFood;
    notifyListeners();
  } 
   
}
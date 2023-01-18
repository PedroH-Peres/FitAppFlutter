import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import '../../models/exercise.dart';

class ExerciseService with ChangeNotifier{
  final List<Exercise> _items = [];

  List<Exercise> get getItems{
    return [..._items];
  }

  int getLength(){
    return _items.length;
  }

  Exercise itemByIndex (int index){
    return _items[index];
  }

  void removeItem (int i){
    _items.removeAt(i);
    notifyListeners();
  }

  void addExercise(Exercise e){
    _items.add(e);
    notifyListeners();
  }


}
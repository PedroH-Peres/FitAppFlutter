import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:fitapp/components/datebar.dart';
import 'package:fitapp/core/services/db_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/exercise.dart';
import '../../pages/homepage.dart';

class ExerciseService with ChangeNotifier {
  List<Exercise> _items = [];
  List<Exercise> _todayItems = [];

  List<Exercise> get getItems {
    return [..._items];
  }

  List<Exercise> get getTodayItems {
    return [..._todayItems];
  }

  void todayItems(){
    List<Exercise> list = [];
    for(int i = 0; i < _items.length; i++){
      if(_items[i].weekDay == HomePage.selectedDay){
        list.add(_items[i]);
      }
    }
    _todayItems = list;
    notifyListeners();

  }

  int getLength() {
    return _items.length;
  }

  Exercise itemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('exercises');
    _items = dataList
        .map((e) => Exercise(
            id: e['id'].toString(),
            titulo: e['title'] as String,
            quantidade: int.tryParse(e['repetition'].toString()),
            tempo: TimeOfDay(hour: int.parse(e['time'].toString().substring(0,2)) , 
            minute: int.parse(e['time'].toString().substring(3, 5)),
            ),
            weekDay: e['weekday'].toString()
            ))
        .toList();
    notifyListeners();
  }

  Future<void> removeItem(int i)async{

    await DbUtil.remove(_items[i].id);
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> addExercise(String titulo, int quant, TimeOfDay tempo, String weekDay) async {
    Exercise exerc = Exercise(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        quantidade: quant,
        tempo: tempo,
        weekDay: weekDay);

    _items.add(exerc);
    String tempoMod = exerc.tempo.toString().substring(10, 15);
    DbUtil.insert('exercises', {
      'id': exerc.id,
      'title': exerc.titulo,
      'repetition': exerc.quantidade,
      'time': tempoMod,
      'weekday': weekDay

    });
    print(tempoMod);
    notifyListeners();
  }
}

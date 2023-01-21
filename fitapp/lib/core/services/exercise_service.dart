import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:fitapp/core/services/db_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/exercise.dart';

class ExerciseService with ChangeNotifier {
  List<Exercise> _items = [];

  List<Exercise> get getItems {
    return [..._items];
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
            minute: int.parse(e['time'].toString().substring(3, 5))
            )))
        .toList();
    notifyListeners();
  }

  Future<void> removeItem(int i)async{

    await DbUtil.remove(_items[i].id);
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> addExercise(String titulo, int quant, TimeOfDay tempo) async {
    Exercise exerc = Exercise(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        quantidade: quant,
        tempo: tempo);

    _items.add(exerc);
    String tempoMod = exerc.tempo.toString().substring(10, 15);
    DbUtil.insert('exercises', {
      'id': exerc.id,
      'title': exerc.titulo,
      'repetition': exerc.quantidade,
      'time': tempoMod
    });
    print(tempoMod);
    notifyListeners();
  }
}

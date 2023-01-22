import 'package:flutter/material.dart';

class Exercise {

  final String id;
  final String titulo;
  final int? quantidade;
  final TimeOfDay? tempo;
  final String weekDay;

  Exercise({
    required this.id,
    required this.titulo,
    required this.weekDay,
    this.quantidade,
    this.tempo
  });

}
import 'package:flutter/material.dart';

class Exercise {

  final String id;
  final String titulo;
  final int? quantidade;
  final TimeOfDay? tempo;

  Exercise({
    required this.id,
    required this.titulo,
    this.quantidade,
    this.tempo
  });

}
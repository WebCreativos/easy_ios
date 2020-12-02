import 'package:flutter/material.dart';

class DiasModel {

  String nombre;
  int repeticiones;
  String dia;
  DiasModel({
    Key key,
    this.nombre = "custom",
    this.repeticiones = 1,
    this.dia = "Lunes"
  });

  DiasModel.fromJson(Map<String, dynamic> json) 
      : nombre = json['nombre'],
        repeticiones = json['repeticiones'],
        dia = json['dia'];
}
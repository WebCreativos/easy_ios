import 'dart:async';

import 'package:sqflite/sqflite.dart';

class Cronometro {
  int idUsuario;
  final int pasos;
  final double calorias;
  final double distancia;
  final String tiempo;
  final String pocisiones;
  final int id;
  String fechaHora;

  Cronometro({this.id, this.pasos,this.distancia, this.calorias, this.tiempo,this.pocisiones});
  void  setidUsuario(int id){
    this.idUsuario = id;
  }
  void  setFechaHora(String fechaHora){
    this.fechaHora = fechaHora; 
  }
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'id_usuario': idUsuario,
      'pasos': pasos,
      'calorias': calorias,
      'distancia': distancia,
      'tiempo': tiempo,
      'fechaHora': fechaHora,
      'pocisiones': pocisiones, 
    };
  }
}

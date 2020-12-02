import 'dart:async';

import 'package:sqflite/sqflite.dart';

class Actividades {
  final int id;
  int idUsuario;
  final int minutos;
  double calorias;
  final int intensidad;
  final String actividad;
  String fecha;

  Actividades({this.id, this.minutos,this.intensidad, this.actividad, this.fecha});
  void  setidUsuario(int id){
    this.idUsuario = id;
  }
  void  setCalorias(double calorias){
    this.calorias = calorias;
  }
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'id_usuario': idUsuario,
      'minutos': minutos,
      'calorias': calorias,
      'actividad': actividad,
      'intensidad': intensidad,
      'fecha': fecha,
    };
  }
}

import 'package:flutter/material.dart';

class ActividadAgendadaModel {
  String date; // DD-MM-YYYY HH:MM
  String actividad;

  ActividadAgendadaModel({Key key, this.date, this.actividad});

  Map<String, dynamic> toJson() => {

    //This toJson satisfy the table on the database

    'date': "${date.split(' ').first}",
    'hora': "${date.split(' ').last}",
    'actividad': actividad
  };

  ActividadAgendadaModel.fromJson(Map<String, dynamic> json)
      : date = json['hora'], // DateTime(year,month,day,hour,minute); we'll use hour and minute to show on the agenda
        actividad = json['actividad'];


}

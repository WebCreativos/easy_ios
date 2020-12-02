import 'package:flutter/material.dart';

class InfoPlanModel {

  String nombre;
  int duracion_dias;
  String precio;

  InfoPlanModel({
    Key key,
    this.nombre = "",
    this.duracion_dias = 0,
    this.precio = ""
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'duracion_dias': duracion_dias,
    'precio': precio
  }; 

  InfoPlanModel.fromJson(Map<String, dynamic> json){
      nombre = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['info_plan']['nombre']:"No hay plan asignado";
      duracion_dias = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['info_plan']['duracion_dias']:0;
      precio = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['info_plan']['precio']:0;
  }

}
import 'package:flutter/material.dart';
import 'dias_model.dart';
class RutinasModel {

  String nombre;
  String main_image;
  Map rutinas;
  int pk;
  String tipo_rutina;

  RutinasModel({
    Key key,
    this.nombre,
    this.rutinas,
    this.main_image,
    this.tipo_rutina,
    this.pk,
  });

  RutinasModel.fromJson(Map<String, dynamic> json)
      : nombre = json['nombre'],
        rutinas = json['rutinas'],
        pk = json["pk"],
        main_image = "https://app.easygymclub.com${json['main_image']}",
        tipo_rutina = json["tipo_rutina"];


  Map<String, dynamic> toMap() =>{
      'nombre': this.nombre,
      'imgPath': this.main_image
  };

}
import 'package:flutter/material.dart';
import 'dias_model.dart';
class ClasesModel {

  String titulo;
  String imagen_principal;
  String video;
  String descripcion;
  int pk;

  ClasesModel({
    Key key,
    this.titulo,
    this.imagen_principal,
    this.video,
    this.descripcion,
    this.pk,
  });

  ClasesModel.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
       descripcion = json['descripcion'],
        video = json['video'],
        pk = json["pk"],
        imagen_principal = "https://app.easygymclub.com${json['imagen_principal']}";


  Map<String, dynamic> toMap() =>{
      'nombre': this.titulo,
      'imgPath': this.imagen_principal
  };

}
import 'package:flutter/material.dart';
import 'info_cliente_model.dart';
class UserModel {

  int pk;
  String username;
  String nombre;
  String apellido;
  int celular;
  int plan;
  String tipo;
  int edad;
  String imagen_perfil;
  Map<String,dynamic> data_info_cliente;
  UserModel({
    Key key,
    this.nombre = "custom",
    this.username = "custom",
    this.apellido = "custom",
    this.imagen_perfil = "https://images.askmen.com/1080x540/2016/01/25-021526-facebook_profile_picture_affects_chances_of_getting_hired.jpg"
  });

  Map<dynamic, dynamic> toJson() => {
    'pk':pk,
    'username': username,
    'nombre': nombre,
    'apellido': apellido,
    'celular':celular,
    'imagen_perfil':imagen_perfil,
    'tipo':tipo ?? "",
    'data_info_cliente': data_info_cliente
  }; // json.encode(Map<String, dynamic>) to read

  //To decode from JSON string to UserModel object
  //json.decode( JSON-String )

  UserModel.fromJson(Map<String, dynamic> json){
      pk = json["pk"];
      username = json['username'];
      celular = json['celular'];
      nombre = json['nombre'];
      apellido = json['apellido'];
      imagen_perfil = json['imagen_perfil'];
      data_info_cliente = json['data_info_cliente'] ?? {};
      tipo = json['tipo'];
  }
}
import 'package:flutter/material.dart';
import 'info_plan_model.dart';
class InfoClienteModel {

  String fecha_pago;
  int gym_socio;
  Map<String, InfoPlanModel>plan;

  InfoClienteModel({
    Key key,
    this.fecha_pago = "",
    this.gym_socio = 0,
    this.plan = null
  });

  Map<String, dynamic> toJson() => {
    'fecha_pago': fecha_pago,
    'gym_socio': gym_socio,
    'plan': plan
  }; 

  InfoClienteModel.fromJson(Map<String, dynamic> json){
      fecha_pago = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['fecha_pago']:"No hay plan asignado";
      gym_socio = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['gym_socio']:0;
      plan = (json['data_info_cliente']['info_plan'] != null)?json['data_info_cliente']['info_plan']:{};
  }

}
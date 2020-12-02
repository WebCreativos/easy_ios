import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easygymclub/User/model/actividad_agendada_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

const IP = 'https://app.easygymclub.com';
class UserAgendaRepository {

  final BehaviorSubject<bool> _actividadAgendadaCorrectamente = BehaviorSubject<bool>();

  Stream<bool> get isAgendadaCorrectamente => _actividadAgendadaCorrectamente.stream;

  // Consulta de actividades en el gimnacio, del dia seleccionado
  // Parametros a recibir: Dia seleccionado
  // Consulta a una API
  Future<List<Map<String,dynamic>>> getActividadesDisponibles(String date) async {

    var user = await User.getSavedUser();
    var url = "${IP}/api/actividades/?gimnasio__id=${user.data_info_cliente['gym_socio']}";
    Map<String,String> header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
      "Accept":"application/json"
    };
    var response = await http.get(
        url,
        headers: header
    );

    List<dynamic> actividades_gym = jsonDecode(response.body)['results'];
    List<Map<String,dynamic>> actividades = List();
    String dayOfWeek =  DateFormat('EEEE').format(DateTime.parse(date));
    for(var actividad in actividades_gym){
    print("${actividad["dia"].toString()[0].toUpperCase()}${actividad["dia"].toString().substring(1)}");
      var actividadDayOfWeek =
          "${actividad["dia"].toString()[0].toUpperCase()}${actividad["dia"].toString().substring(1)}";
      if (date == actividad["dia"] || dayOfWeek == actividadDayOfWeek) {
        actividades.add({
          'id':actividad['id'],
          'hora': actividad["hora"],
          'actividad':actividad["nombre"]
        });
      }
    }

    return actividades;

  }

  // Consulta de actividades ya agendadas
  // Parametros a recibir: Dia seleccionado
  // Consulta a SQLITE

  Future<List<ActividadAgendadaModel>> getActividadesAgendadas(String date) async {

    var dio = Dio();
    var user = await User.getSavedUser();
    var url = "${IP}/api/usuarios/${user.pk}/getAgenda/?date=$date";
    Map<String,dynamic> header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    Response response = await dio.get(url,options: Options(headers: header));
    List<dynamic> maps = response.data;
    return List.generate(maps.length, (i) {
      return ActividadAgendadaModel(
          date: maps[i]['actividad_data']['hora'],
          actividad: maps[i]['actividad_data']['nombre']
      );
    });

  }

  // Agendarse
  // Parametro a recibir: Dia seleccionado
  // Parametros a mandar: Dia seleccionado y usuario
  // A devolver: Si esta ocupado o no

  Future<void> setActividad(String pkActividad) async {

    var dio = Dio();
    var user = await User.getSavedUser();
    var url = "${IP}/api/usuarios/saveAgenda/";
    Map<String,dynamic> header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    var body = {
      "usuario":user.pk,
      "actividad":pkActividad
    };
    try {
      await dio.post(url,data: body,options: Options(headers: header));
    } catch (e) {
      ErrorController.instance.setErrorToShow(e);
    }

    _actividadAgendadaCorrectamente.sink.add(true);
  }

  // Stream para refrescar la pagina si se logro agendar

  void closeStreams(){
    _actividadAgendadaCorrectamente.close();
  }

}
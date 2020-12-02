import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/user.dart';

const IP = 'https://app.easygymclub.com';

class RankingRepository {

  // Relacionado a Ranking Screen

  // Mi puesto

  Future<Map<String,dynamic>> getMiRanking() async {
    UserModel user = await User.getSavedUser();
    String url = IP + "/api/usuarios/?ordering=puntos&info_cliente__gym_socio=${user.data_info_cliente['gym_socio']}";
    Map<String,String> header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.userAgentHeader: "dio"
    };

    var dio = Dio(BaseOptions(
        headers: header,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json
    ));

    var response;
    try{
      response = await dio.get(
          url,
      );
    }catch(e){
      ErrorController.instance.setErrorToShow(e.toString());
    }

    // List of Clientes gimnasio

    int puesto = 0;

    List lista = response.data['results'];

    for(var user_aux in lista){
      if(user_aux['px'] == user.pk){
        break;
      }
      puesto++;
    }

    return {
      'puntos':(puesto-1!=-1)?lista[puesto-1]['data_info_cliente']['puntos'] : 0,
      'puesto':puesto++
    };
  }

  // Mi historial

  Future<List<Map>> getMiHistorial() async {

    UserModel user = await User.getSavedUser();
    var url = "${IP}/api/usuarios/metas/?usuario__id=${user.pk}";

    Map<String,String> header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.userAgentHeader: "dio"
    };

    var dio = Dio(BaseOptions(
        headers: header,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json
    ));

    Response response;

    try {
      response = await dio.get(url);
    } catch (e) {
      ErrorController.instance.setErrorToShow(e);
    }

    List<Map> metasResponse = List<Map>();

    for(var data in response.data['results']){
      metasResponse.add(
        {
          'meta':data['meta']['nombre'],
          'actividad':data['info_meta']['descripcion'],
          'puntos':data['meta']['puntos']
        }
      );
    }

    return metasResponse;
  }
}
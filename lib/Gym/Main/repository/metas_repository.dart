import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easygymclub/Gym/Main/model/gym_model.dart';
import 'package:easygymclub/Gym/Main/model/metas_model.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:http/http.dart' as http;
import 'package:easygymclub/utils/user.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'dart:convert' show utf8;

const IP = 'https://app.easygymclub.com';

class MetasRepository {

  Future<List<MetasModel>> getMetas() async{
    UserModel user =  await User.getSavedUser();
    if(user.data_info_cliente['gym_socio'] == null){
      return List<MetasModel>();
    }

    String url = IP + "/api/gimnasios/metas/?gimnasio__pk=${user.data_info_cliente['gym_socio']}";
    http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
          "Accept":"application/json"
        }
    );
    List<dynamic> data = await json.decode(utf8.decode(response.bodyBytes))["results"];
    List<MetasModel> metas = (data).map((json)=> MetasModel.fromJson(json)).toList();
    return metas;
  }

  Future <List<GymModel>> getAllGyms() async {
    var url = IP + '/api/gimnasios/';

    var dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json
    ));

    Response response;

    try {
      response = await dio.get(url);
    } catch (e) {
      ErrorController.instance.setErrorToShow(e.toString());
    }

    List gyms = response.data['results'];

    return gyms.map((e) => GymModel.fromJson(e)).toList();
  }


}
import 'dart:convert';
import 'dart:io';
import 'package:easygymclub/Dieta/model/dieta_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:http/http.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

const IP = 'https://app.easygymclub.com';

class DietaRepository {

  Future<List<DietaModel>> getDieta(String tipo) async{
    UserModel user =  await User.getSavedUser();
    String url;
    switch(tipo){
      case "App":
      url = IP + "/api/dietas/allDietas/";
      break;
      case "Usuario":
      url = IP + "/api/usuarios/dietas/?usuario__id=${user.pk}";
      break;
      case "Gimnasio":
      url = IP + "/api/gimnasios/dietas/?gimnasio__id=" + user.data_info_cliente['gym_socio'].toString();
      break;
    }
    http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
          "Accept":"application/json",
          'charset':'utf-8'
        }
    );

    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes))['results'];
    List<DietaModel> listAuxiliar = data.map((json) => DietaModel.fromJson(json)).toList();

    return listAuxiliar;
  }


}
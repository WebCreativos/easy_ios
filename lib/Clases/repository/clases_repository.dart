import 'dart:convert';
import 'dart:io';
import 'package:easygymclub/Clases/model/clases_model.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:soundpool/soundpool.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;


const IP = 'https://app.easygymclub.com';

class ClasesRepository {
  // Soundpool variable

  Soundpool _soundpool;
  int _streamId;

  ///Rules for Soundpool

  ///DO NOT create the Soundpool instance multiple times; DO create a Soundpool for logically connected sounds (ex. sounds for level, sounds with the same streamType),
  ///DO NOT load the same file multiple times; DO load it once (ideally while the application is starting), store sound id and use play(soundId),
  ///DO NOT leave sounds loaded in memory when no longer used; DO call release() or dispose() when sounds are no longer useful,
  ///DO NOT play music files; DO use plugin that is intended for that.

  // Obtener clases
  // Ej: Plan 1 - 10 dias - Ganar Masa muscular

  Future<List<ClasesModel>> getClases() async{
    UserModel user =  await User.getSavedUser();
    print(user.data_info_cliente); 
    print(IP + "/api/clases/?gym_id=${user.data_info_cliente['gym_socio']}"); 
    http.Response response = await http.get(
        IP + "/api/clases/?gym__id=${user.data_info_cliente['gym_socio']}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
          "Accept":"application/json",
          'charset':'utf-8'
        } 
    );
    var data = json.decode(utf8.decode(response.bodyBytes))["results"];
    print(data);
    List<ClasesModel> _rutinas =(data as List).map((i){
        return ClasesModel.fromJson(i);
    }).toList();
    return _rutinas;
  }

}
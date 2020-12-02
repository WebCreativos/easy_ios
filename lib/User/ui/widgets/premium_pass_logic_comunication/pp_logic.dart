
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:location/location.dart';

const IP = 'https://app.easygymclub.com';

class PPLogic {


  Future<List<String>> availableGyms() async {

    var location = Location();
    LocationData myCurrentLocation = await location.getLocation();
    
    List<dynamic> gimnasios = await _getAllGyms();
    List<Map<String,dynamic>> respuesta = List<Map<String,dynamic>>();
    
    for(var gym in gimnasios){
      if(_calculateDistance(
          myCurrentLocation,
      LocationData.fromMap({
      'latitude':gym['latitud'],
      'longitude':gym['longitud']
      })
      )){
        respuesta.add(gym);
      }
    }
    
    return respuesta.map((gym) => gym['nombre'].toString()).toList();

  }

  bool _calculateDistance(LocationData myLocation,LocationData gymLocation){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((myLocation.latitude - gymLocation.latitude) * p)/2 +
        c(myLocation.latitude * p) * c(gymLocation.latitude * p) *
            (1 - c((gymLocation.longitude - myLocation.longitude) * p))/2;
    var km = 12742 * asin(sqrt(a));
    if(km < 100){
      return true;
    }
    return false;
  }



  Future <List<dynamic>> _getAllGyms() async {

    var url = IP + '/api/gimnasios/';

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

    try{
      response = await dio.get(url);
    }catch(e){
      ErrorController.instance.setErrorToShow(e.toString());
    }

    return response.data['results'];

  }
}
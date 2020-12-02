import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const IP = 'https://app.easygymclub.com';

class ErrorController {

  ErrorController._constructor();

  static final ErrorController instance = ErrorController._constructor();

  //Stream to listen errors and show with a Snackbar
  final PublishSubject<String> _controllerErrors = PublishSubject<String>();

  Stream<String> get theresAnyError => _controllerErrors.stream;

  static Future<String> getJWT() async {

    var pref = await SharedPreferences.getInstance();
    Map<String,dynamic> jwt = jsonDecode(pref.getString("easygymclubjwt"));

    // /api/usuarios/loggedInUser/
    var url = "${IP}/api/usuarios/loggedInUser/";
    Map<String,String> header = {
      HttpHeaders.authorizationHeader: "Bearer ${jwt["access"]}",
      "Accept":"application/json"
    };

    var response;
    var dio = Dio(BaseOptions(
        headers: header,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json
    ));

    try {
      response = await dio.get(url);
    } catch (e) {
      url = "${IP}/api/login/token/refresh/";
      try {
        response = await dio.post(
            url,
            data: {
              "refresh": jwt["refresh"]
            },
            options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: Headers.jsonContentType
                }
            )
        );
        jwt["access"] = response.data["access"];
        pref.setString("easygymclubjwt", jsonEncode(jwt));
      } catch (e) {
        ErrorController.instance.setErrorToShow("TokenException");
      }
    }

    return jwt["access"];
  }

  // Set error to show
  void setErrorToShow(String error) {
    _controllerErrors.sink.add(error);
  }

  void dispose() {
    _controllerErrors.close();
  }
}

class TokenException implements Exception {
  @override
  String toString() {
    print("Error intentando refrescar el token");
    return super.toString();
  }
}

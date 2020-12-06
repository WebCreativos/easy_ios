import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/NotificationsController/notifications_controller.dart';
import 'package:easygymclub/utils/user_type.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const IP = 'https://app.easygymclub.com';

class UserRepository with UserType {
  SharedPreferences _pref;
  final ErrorController _errorController = ErrorController.instance;
  final NotificationsController _notificationsController =
      NotificationsController();

  final BehaviorSubject<UserModel> _controllerUser =
      BehaviorSubject<UserModel>();

  //This StreamController could be an Icon or a Image
  final BehaviorSubject<Object> _controllerAvatarImage =
  BehaviorSubject<Object>();

  //Stream to listen errors and show with a Showbar
  Stream<UserModel> get userInstance => _controllerUser.stream;

  Stream<dynamic> get userAvatarImage => _controllerAvatarImage.stream;

  File _fileImageProfile;
  bool _userFree = false;

  bool get isUserFree => _userFree;

  UserRepository() {
    checkUserLogged();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((connection) {
      if (connection == ConnectivityResult.none) {
        _controllerUser.isEmpty.then((value) {
          if (!value) {
            LogOut();
            _errorController.setErrorToShow("CloseSession");
          }
        });
      }
    });
  }

  // AvatarImage

  void setFileImageProfile(File img) {
    _fileImageProfile = img;
  }

  Future<void> changeAvatarImageState(Object image) {
    _controllerAvatarImage.sink.add(image);
  }

  void iconToStream(Widget icon) {
    _controllerAvatarImage.sink.add(icon);
  }

  // User
  Future<void> checkUserLogged() async {
    var user = await getSavedUser();
    if (user != null) {
      _controllerUser.sink.add(user);
      _notificationsController.updateTokenUsuario();
      _notificationsController.initNotifications();
      if ((user.tipo == userTypeString(user_types.Cliente_normal)) ||
          (user.tipo == userTypeString(user_types.Personal_trainer))) {
        _userFree = true;
        _notificationsController.setFreeSubscription();
      } else {
        _userFree = false;
        _notificationsController.setPremiumSubscription();
        _notificationsController
            .setSubscription(user.data_info_cliente['gym_socio']);
      }
    } else { 
      _controllerUser.sink.add(null);
    }
  }

  Future<UserModel> getSavedUser() async {
    _pref = await SharedPreferences.getInstance();
    try {
      return UserModel.fromJson(jsonDecode(_pref.getString("user")));
    } catch (Exception) {
      print("There's no user logged");
      return null;
    }
  }

  Future<void> LogIn(String email, String password) async {
    /// Obtenemos los datos del usuario
    const url = "${IP}/api/login/token/";
    var dataBody = {"username": email, "password": password};
    var header = {"Accept": "application/json"};

    var response = await http
        .post(url, body: dataBody, headers: header)
        .catchError((error) {
      _errorController.setErrorToShow("Error, chequea tu conexion");
      return Future.error("Error,chequea tu conexion");
    });

    Map aux = jsonDecode(response.body);

    if (response.statusCode != 200) {
      var error;
      aux.forEach((key, value) {
        if (value.runtimeType != String) {
          error = value.first;
          _errorController.setErrorToShow(error.first);
        }
        error = value;
        _errorController.setErrorToShow("Email y/o contraseña incorectos");
      });
      return Future.error(error);
    }
    // Guardamos el JWT y pedimos los datos del usuario

    await saveJWT(aux);

    UserModel user = await getDataUserAndSaveIt();
    _notificationsController.initNotifications();
    if ((user.tipo == userTypeString(user_types.Cliente_normal)) ||
        (user.tipo == userTypeString(user_types.Personal_trainer))) {
      _notificationsController.setFreeSubscription();
      _userFree = true;
    } else {
      _notificationsController.setPremiumSubscription();
      _userFree = false;
    }

    //Streamear el usuario
    _controllerUser.sink.add(user);

    //Guardar el usuario
    saveUser(user);

    return true;
  }

  Future<UserModel> getDataUserAndSaveIt() async {
    const url = "${IP}/api/usuarios/loggedInUser/";
    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
      "Bearer ${await ErrorController.getJWT()}",
      "Accept": "application/json"
    };

    var response = await http.get(url, headers: header);

    var data = jsonDecode(response.body);
    data['imagen_perfil'] = IP + "${data['imagen_perfil']}";
    UserModel _userModel = UserModel.fromJson(data);
    return _userModel;
  }

  Future<void> saveJWT(Map<String, dynamic> body) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString("easygymclubjwt", jsonEncode(body));
  }

  void removeJWT() async {
    _pref = await SharedPreferences.getInstance();
    _pref.remove("easygymclubjwt");
  }

  void LogOut() {
    _controllerUser.sink.add(null);
    _controllerAvatarImage.sink.add(null);
    removeUser();
    removeJWT();
    _notificationsController.dispose();
  }

  Future<void> updateInfoUser(UserModel user) async {
    var url = "${IP}/api/usuarios/${user.pk}/";

    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
      "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.userAgentHeader: "dio"
    };

    var dio = Dio(BaseOptions(
        headers: header,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json));

    Map<String, dynamic> body = {
      "pk": user.pk,
      "username": user.username,
      "celular": user.celular,
      "nombre": user.nombre,
      "apellido": user.apellido,
      "is_admin": false,
      "is_active": true,
      if (_fileImageProfile != null)
        "imagen_perfil": "${base64Encode(_fileImageProfile.readAsBytesSync())}",
      "info_cliente": {
        "fecha_pago": user.data_info_cliente['fecha_pago'],
        "usuario": user.pk,
        "gym_socio": user.data_info_cliente['gym_socio'],
        "sexo": user.data_info_cliente['sexo'],
        "edad": user.data_info_cliente['edad'],
        "altura": user.data_info_cliente['altura'],
        "peso": user.data_info_cliente['peso'],
        "pecho": user.data_info_cliente['pecho'],
        "cintura": user.data_info_cliente['cintura'],
        "piernas": user.data_info_cliente['piernas'],
        "tipo_de_figura": user.data_info_cliente['tipo_de_figura'],
        "puntos": 0,
        "info_plan": null
      },
      "tipo": user.tipo
    };

    try {
      await dio.put(url, data: body);
    } catch (e) {
      ErrorController.instance.setErrorToShow(e.toString());
    }

    UserModel dataUser = await getDataUserAndSaveIt();
    _controllerUser.sink.add(dataUser);
    saveUser(dataUser);
  }

  Future<List<UserModel>> getUsuarios(String tipoUsuario) async {
    String url = IP + "/api/usuarios/?tipo=$tipoUsuario";
    var response = await get(url, headers: {
      HttpHeaders.authorizationHeader:
      "Bearer ${await ErrorController.getJWT()}",
      "Accept": "application/json"
    });
    var data = json.decode(response.body)["results"];
    List<UserModel> usuarios = (data as List).map((i) {
      return UserModel.fromJson(i);
    }).toList();
    return usuarios;
  }

  void saveUser(UserModel user) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString("user", jsonEncode(user));
    //getSavedUser();
  }

  void removeUser() async {
    _pref = await SharedPreferences.getInstance();
    _pref.remove("user");
  }

  Future<void> signUp(String password, String sexo_seleccionado, String email,
      String tipo, String nombre, String apellido, String celular, int edad,
      {String descripcionTrainer, int gymPk = null}) async {
    var sexo;
    switch (sexo_seleccionado) {
      case "Masculino":
        sexo = "M";
        break;
      case "Femenino":
        sexo = "F";
        break;
      case "Otro":
        sexo = "O";
        break;
    }

    var image;
    if (_fileImageProfile != null) {
      image = "${base64Encode(_fileImageProfile.readAsBytesSync())}";
    } else {
      ByteData bytes = await rootBundle.load('assets/img/default-profile.png');
      var buffer = bytes.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      image = "$m";
    }
    var url = "${IP}/api/usuarios/";
    var dataBody = {
      "username": email,
      "password": password,
      "nombre": nombre,
      "apellido": apellido,
      "celular": celular,
      "tipo": tipo,
      "imagen_perfil": image,
      "info_cliente": {"sexo": sexo, "gym_socio": gymPk}
    };
    
    if(edad!=null)
      dataBody["info_cliente"]["edad"]= edad;

    var dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType, responseType: ResponseType.json));

    try {
      await dio.post(
        url,
        data: dataBody,
      );
    } catch (e) {
      _errorController.setErrorToShow("Email ocupado, intente con otro");
      return Future.error("Email ocupado, intente con otro");
    }

    _controllerAvatarImage.sink.add(null);
    LogIn(email, password);
  }

  Future<void> newPassword(String email) async {
    var url = "${IP}/api/usuarios/recoverPassword/";

    var dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType, responseType: ResponseType.json));

    var dataBody = {'email': email};

    try {
      await dio.post(url, data: dataBody);
    } catch (e) {
      _errorController.setErrorToShow("Error, vuelva a intentar");
      return Future.error("Error, vuelva a intentar");
    }
  }

  Future<void> enviarSugerencia(String texto) async {
    var url = "${IP}/api/sugerencias/";

    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
          "Bearer ${await ErrorController.getJWT()}",
      HttpHeaders.userAgentHeader: "dio"
    };

    var dio = Dio(BaseOptions(
        headers: header,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json));

    var dataBody = {"sugerencia": texto};

    try {
      await dio.post(url, data: dataBody);
    } catch (e) {
      _errorController.setErrorToShow("Error, vuelva a intentar");
      return Future.error("Error, vuelva a intentar");
    }
  }

  void onDispose() {
    print("### Disposing UserRepository");
    _controllerUser.close();
    _controllerAvatarImage.close();
    _notificationsController.dispose();
  }
}

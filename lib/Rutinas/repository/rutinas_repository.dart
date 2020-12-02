import 'dart:convert';
import 'dart:io';

import 'package:easygymclub/Rutinas/model/rutinas_model.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundpool/soundpool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:http/http.dart'
as http;
import 'dart:convert'
show utf8;


const IP = 'https://app.easygymclub.com';

class RutinasRepository {
  // Soundpool variable

  Soundpool _soundpool;
  int _streamId;

  ///Rules for Soundpool

  ///DO NOT create the Soundpool instance multiple times; DO create a Soundpool for logically connected sounds (ex. sounds for level, sounds with the same streamType),
  ///DO NOT load the same file multiple times; DO load it once (ideally while the application is starting), store sound id and use play(soundId),
  ///DO NOT leave sounds loaded in memory when no longer used; DO call release() or dispose() when sounds are no longer useful,
  ///DO NOT play music files; DO use plugin that is intended for that.

  // Obtener rutinas
  // Ej: Plan 1 - 10 dias - Ganar Masa muscular

  Future < List < RutinasModel >> getRutinas(String tipo) async {
    UserModel user = await User.getSavedUser();

    String url;
    switch (tipo) {
      case "App":
        url = IP + "/api/rutinas/allRutinas/";
        break;
      case "Usuario":
        url = IP + "/api/usuarios/rutinas/?usuario__id=${user.pk}";
        break;
      case "Gimnasio":
        url = IP + "/api/gimnasios/rutinas/?gimnasio__id=${user.data_info_cliente['gym_socio']}";
        break;
    }
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
        "Accept": "application/json",
        'charset': 'utf-8'
      }
    );
    var data = json.decode(utf8.decode(response.bodyBytes))["results"];
    print(data);
    List < RutinasModel > _rutinas = (data as List).map((i) {
      return RutinasModel.fromJson(i);
    }).toList();
    return _rutinas;
  }


  // Realizando ejercicio
  final BehaviorSubject < int > _indexEjercicioRealizando = BehaviorSubject < int > .seeded(0);
  Stream < int > get realizandoEjercicio => _indexEjercicioRealizando.stream;

  void setEjercicioListo(int siguienteEjercicio) {
    _indexEjercicioRealizando.sink.add(siguienteEjercicio);
  }

  void dispose() {
    if (_soundpool != null) _soundpool.release();
    _indexEjercicioRealizando.close();
  }

  // Soundpool Logic

  Future < Soundpool > makeSound() async {
    if (_soundpool == null) _soundpool = Soundpool(streamType: StreamType.ring);

    int soundId = await rootBundle.load("assets/sounds/ejercicio_start.wav").then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    _streamId = await _soundpool.play(soundId);
  }

  // Pause sound

  Future < void > pauseSound() async {

    await _soundpool.pause(_streamId);
  }




}
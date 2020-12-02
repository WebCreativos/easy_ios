import 'dart:async';
import 'dart:io';

import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/repository/user_api.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class UserBloc implements Bloc {

  final UserApi _userApi = UserApi();

  Future<void> LogIn (nickname,password) => _userApi.LogIn(nickname,password);
  void LogOut () => _userApi.LogOut();
  void initAvatarImage(Widget icon) => _userApi.initAvatarImage(icon);

  Future<void> changeAvatarImage(Object image) =>
      _userApi.changeAvatarImage(image);
  Future<void> updateInfoUser(UserModel user) => _userApi.updateInfoUser(user);

  Future<void> signUp(String password, String sexo, String email, String tipo,
          String nombre, String apellido, String celular, int edad,
          {String descripcionTrainer, int gymPk}) =>
      _userApi.signUp(
          password, sexo, email, tipo, nombre, apellido, celular, edad,
          descripcionTrainer: descripcionTrainer,
          gymPk: gymPk);
  void setFileImageProfile(File img) => _userApi.setFileImageProfile(img);

  Future<void> newPassword(String email) => _userApi.newPassword(email);

  Future<void> enviarSugerencia(String texto) =>
      _userApi.enviarSugerencia(texto);

  Stream userInstance () => _userApi.userInstance();
  Stream avatarImage () => _userApi.avatarImage();

  Future<UserModel> getUserData () => _userApi.getUserData();
  Future<List<UserModel>> getUsuarios (String tipo) => _userApi.getUsuarios(tipo);

  bool get isUserFree => _userApi.isUserFree;


  @override
  void dispose() {
    _userApi.onDispose();
  }

}
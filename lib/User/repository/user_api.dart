import 'dart:io';

import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserApi {

  final UserRepository _userRepo = UserRepository();

  Future<void> LogIn (nickname,password) => _userRepo.LogIn(nickname,password);
  void LogOut () => _userRepo.LogOut();
  void onDispose() => _userRepo.onDispose();
  void initAvatarImage(Widget icon) => _userRepo.iconToStream(icon);

  Future<void> changeAvatarImage(Object image) =>
      _userRepo.changeAvatarImageState(image);
  Future<void> updateInfoUser(UserModel user) => _userRepo.updateInfoUser(user);

  Future<void> signUp(String password, String sexo, String email, String tipo,
          String nombre, String apellido, String celular, int edad,
          {String descripcionTrainer, int gymPk}) =>
      _userRepo.signUp(
          password, sexo, email, tipo, nombre, apellido, celular, edad,
          descripcionTrainer: descripcionTrainer,
          gymPk: gymPk);
  bool get isUserFree => _userRepo.isUserFree;
  void setFileImageProfile(File img) => _userRepo.setFileImageProfile(img);

  Future<void> newPassword(String email) => _userRepo.newPassword(email);

  Future<void> enviarSugerencia(String texto) =>
      _userRepo.enviarSugerencia(texto);

  Stream userInstance () => _userRepo.userInstance;
  Stream avatarImage () => _userRepo.userAvatarImage;

  Future<UserModel> getUserData () => _userRepo.getSavedUser();
  Future<List<UserModel>> getUsuarios (String tipo) => _userRepo.getUsuarios(tipo);
}
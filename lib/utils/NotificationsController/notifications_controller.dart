import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:locally/locally.dart';

class NotificationsController {
  static NotificationsController _instance = NotificationsController._();
  static
  const _IP = "https://app.easygymclub.com/api";

  NotificationsController._();

  factory NotificationsController() => _instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Locally locally;

  void initNotifications() async {
    print("### Iniciando notificaciones");
    _firebaseMessaging.configure(
      onMessage: (Map < String, dynamic > message) async {
        locally.show(title: message['notification']['title'],message:message['notification']['body'],);
        print("### onMessage: $message");
      },
      onLaunch: (Map < String, dynamic > message) async {
        print("### onLaunch: $message");
      },
      onResume: (Map < String, dynamic > message) async {
        print("### onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    this.token.then((value) => print("### Token $value"));
  }

  /// Token para enviar notificaciones unicamente a este dispositivo
  Future < String > get token => _firebaseMessaging.getToken();

  /// Suscripcion para recibir notificaciones unicamente del gimnasio asociado
  void setSubscription(int gym) {
    print("### Suscribiendose a ${gym}Notificaciones");
    _firebaseMessaging.subscribeToTopic("${gym}Notifications");
  }

  void unsetSubscription(int gym) =>
    _firebaseMessaging.unsubscribeFromTopic("${gym}Notifications");

  /// Suscripcion para recibir notificaciones unicamente si se es usuairo premium
  void setPremiumSubscription() {
    print("### Suscribiendose a premiumSubscription");
    _firebaseMessaging.subscribeToTopic("premiumSubscription");
  }

  void unsetPremiumSubscription() =>
    _firebaseMessaging.unsubscribeFromTopic("premiumSubscription");

  /// Suscripcion para recibir notifiaciones unicamente si se es usuario free
  void setFreeSubscription() {
    print("### Suscribiendose a freeSubscription");
    _firebaseMessaging.subscribeToTopic("freeSubscription");
  }

  void unsetFreeSubscription() =>
    _firebaseMessaging.unsubscribeFromTopic("freeSubscription");

  Future < void > updateTokenUsuario() async {
    var url = _IP + "/usuarios/mobileToken/";
    var header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
    };
    var user = await User.getSavedUser();
    var body = {
      'token': await this.token, 
    };
    var dio = Dio(BaseOptions(headers: header));

    try {
      await dio.put(url, data: body);
      print(
        "### Token-usuario registrado para notificaciones particulares ###");
    } catch (e) {
      print("### Error intentando registrar token para notificaciones ###");
    }
  }

  Future < void > removeTokenUsuario() async {
    var url = _IP + "endpoint";
    var header = {
      HttpHeaders.authorizationHeader: "Bearer ${await ErrorController.getJWT()}",
    };
    var user = await User.getSavedUser();
    var body = {
      'usuario': user.pk
    };
    var dio = Dio(BaseOptions(headers: header));

    try {
      await dio.post(url, data: body);
      print("### Token-usuario eliminado ###");
    } catch (e) {
      print("### Error intentando eliminar token para notificaciones ###");
    }
  }
  void dispose() {
    _firebaseMessaging.deleteInstanceID();
  }
}
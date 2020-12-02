import 'package:flutter/foundation.dart';

enum MiddlewareStatus { Pass, NotPass }

class Middleware {
  static Middleware _instance = Middleware._();

  String _mensajePreventivo = "";
  MiddlewareStatus estado = MiddlewareStatus.Pass;

  Middleware._();

  factory Middleware() => _instance;

  void goTo({VoidCallback callbackGoTo, Function callbackExcept}) {
    if (estado == MiddlewareStatus.NotPass) {
      callbackExcept(_mensajePreventivo);
      debugPrint("Recuerde volver a bajar el middleware");
      return;
    }

    _mensajePreventivo = "";
    callbackGoTo();
  }

  void middlewareUp(String mensajePreventivo) {
    estado = MiddlewareStatus.NotPass;
    _mensajePreventivo = mensajePreventivo;
    debugPrint("Recuerde volver a bajar el middleware");
  }

  void middlewareDown() {
    estado = MiddlewareStatus.Pass;
    _mensajePreventivo = "";
  }
}

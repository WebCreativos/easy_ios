import 'package:flutter/material.dart';

class CronometroProvider extends ChangeNotifier {
  String tipoDeCuerpo = "Selecciona tu figura";

  CronometroProvider(this.tipoDeCuerpo);

  void nuevoValor(String nuevoTipoDeCuerpo) {
    tipoDeCuerpo = nuevoTipoDeCuerpo;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class TipoDeCuerpoProvider extends ChangeNotifier {
  String tipoDeCuerpo = "Selecciona tu figura";

  TipoDeCuerpoProvider(this.tipoDeCuerpo);

  void nuevoValor(String nuevoTipoDeCuerpo) {
    tipoDeCuerpo = nuevoTipoDeCuerpo;
    notifyListeners();
  }
}

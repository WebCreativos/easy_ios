import 'dart:io';

import 'package:easygymclub/EasyFit/models/cronometro.dart';
import 'package:easygymclub/EasyFit/repository/cronometros_repository.dart';
import 'package:flutter/material.dart';

class CronometrosApi {

  final CronometrosRepository _cronoRepo = CronometrosRepository();

  Future<void> saveCronometro (cronometro) => _cronoRepo.saveCronometro(cronometro);
  Future < List < Map >> cronometrosList () => _cronoRepo.cronometrosList(); 
  Future<void> deleteCronometro (pk) => _cronoRepo.deleteCronometro(pk); 
  
  //Setters
  void setPasos (pasos) => _cronoRepo.setPasos(pasos);
  void setDistancia (distancia) => _cronoRepo.setDistancia(distancia);
  void setCalorias (calorias) => _cronoRepo.setCalorias(calorias);
  void setTiempo (tiempo) => _cronoRepo.setTiempo(tiempo);
  void setPocisiones (pocisiones) => _cronoRepo.setPocisiones(pocisiones);

  //Closers
  void closePosiciones () => _cronoRepo.closePosiciones();
  void closeTiempo () => _cronoRepo.closeTiempo();
  void closePasos () => _cronoRepo.closePasos();
  void closeCalorias () => _cronoRepo.closeCalorias();
  void closeDistancia () => _cronoRepo.closeDistancia();


  //Getters
  Stream<int> getPasos(){
    return _cronoRepo.getPasos();
  }
  Stream<double> getDistancia() {
    return _cronoRepo.getDistancia();
  }
  Stream<double> getCalorias() {
    return _cronoRepo.getCalorias();
  }
  Stream<String> getTiempo() {
    return _cronoRepo.getTiempo();
  }
  Stream<String> getPocisiones() {
    return _cronoRepo.getPocisiones();
  }
}
import 'package:easygymclub/EasyFit/repository/cronometros_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:easygymclub/EasyFit/models/cronometro.dart';

class CronometrosBloc extends Bloc{
  int _pasos = 1;
  double _calorias = 1.0;
  double _distancia = 1.0;
  String _pocisiones = "";
  String _tiempo = "00:00";
  double getDistancia(){
    return _distancia;
  }
  double getCalorias(){
    return this._calorias;
  }
  final CronometrosApi _cronometrosApi = CronometrosApi();
  void saveCronometro (){
    Cronometro cronometro = new Cronometro(calorias: _calorias,distancia: _distancia,pasos: _pasos,tiempo: _tiempo, pocisiones:_pocisiones);
    _cronometrosApi.saveCronometro(cronometro);
  }
  Future<void> cronometrosList() => _cronometrosApi.cronometrosList();
    void setPasos (pasos) => _cronometrosApi.setPasos(pasos);
  void setDistancia (distancia) => _cronometrosApi.setDistancia(distancia);
  void setCalorias (calorias) => _cronometrosApi.setCalorias(calorias); 
  void setTiempo (tiempo) => _cronometrosApi.setTiempo(tiempo); 
  void setPocisiones (pocisiones) => _cronometrosApi.setPocisiones(pocisiones); 
  void deleteCronometro (pk) => _cronometrosApi.deleteCronometro(pk); 
  Stream<int> getPasos(){
    return _cronometrosApi.getPasos();
  }
  CronometrosBloc(){
    _cronometrosApi.getPasos().listen((data){
      this._pasos = data;
    });
    _cronometrosApi.getCalorias().listen((data){
      this._calorias = data;
    });
    _cronometrosApi.getDistancia().listen((data){
      this._distancia = data;
    });
    _cronometrosApi.getTiempo().listen((data){
      this._tiempo = data;
    });
    _cronometrosApi.getPocisiones().listen((data){
      print(data); 
      this._pocisiones = data;
    });

  }
  @override
  void dispose() {
    _cronometrosApi.closeCalorias();
    _cronometrosApi.closeDistancia();
    _cronometrosApi.closePasos();
    _cronometrosApi.closePosiciones();
    _cronometrosApi.closeTiempo();
  }

}
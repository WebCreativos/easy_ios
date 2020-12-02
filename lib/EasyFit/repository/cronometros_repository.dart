import 'dart:async';
import 'package:easygymclub/EasyFit/models/cronometro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/user.dart';

class CronometrosRepository {

  Database _database;
  int pasos;
  int idUsuario;
  double distancia;
  final BehaviorSubject<int> _controllerPasos = BehaviorSubject<int>();
  final BehaviorSubject<double> _controllerDistancia = BehaviorSubject<double>();
  final BehaviorSubject<double> _controllerCalorias = BehaviorSubject<double>();
  final BehaviorSubject<String> _controllerTiempo = BehaviorSubject<String>();
  final BehaviorSubject<String> _controllerPocisiones = BehaviorSubject<String>();


  void setPasos(int pasos){
    _controllerPasos.sink.add(pasos);
  }
  void setDistancia(double distancia){
    _controllerDistancia.sink.add(distancia);
  }
  void setCalorias(double calorias){
    _controllerCalorias.sink.add(calorias);
  }
  void setTiempo(String tiempo){
    _controllerTiempo.sink.add(tiempo);
  }
  void setPocisiones(String pocisiones){
    _controllerPocisiones.sink.add(pocisiones);
  }

  Stream<int>  getPasos(){
    return _controllerPasos.stream;
  }
  Stream<double>  getDistancia(){ 
    return _controllerDistancia.stream;
  } 
  Stream<double>  getCalorias(){
    return _controllerCalorias.stream;
  } 
  Stream<String>  getTiempo(){
    return _controllerTiempo.stream;
  } 
  Stream<String>  getPocisiones(){
    return _controllerPocisiones.stream;
  } 

  void closePosiciones(){
    _controllerPocisiones.close();
  }
  void closeTiempo(){
    _controllerTiempo.close();
  }
  void closePasos(){
    _controllerPasos.close();
  }
  void closeCalorias(){
    _controllerCalorias.close();
  }
  void closeDistancia(){
    _controllerDistancia.close();
  }


  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "easyadb.db");
    return await openDatabase(
        path,
        onCreate: (db, version) {
          print("Creating database");
          return db.execute(''' 
          create table cronometros(id INTEGER PRIMARY KEY, id_usuario INTEGER, pasos INTEGER, calorias INTEGER, distancia INTEGER, tiempo TEXT,pocisiones TEXT, fechahora DATETIME)
          '''
          ); // campo => hora 
        },
        version: 1
    );

  }
 
  Future < List < Map >> cronometrosList() async {
    final Database db = await _initDatabase(); 
    final List < Map < String, dynamic >> maps = await db.query('cronometros');
    List<Map> cronometros;
    cronometros = List.generate(maps.length, (i) {
      return maps[i];
    });
    print("lista cronometros");
    return cronometros;
  }

  Future<void> saveCronometro(Cronometro cronometro) async {
    print(cronometro); 
    UserModel user =  await User.getSavedUser();
    var now = new DateTime.now();
    cronometro.setidUsuario(user.pk);
    cronometro.setFechaHora(now.toString().split(".")[0]);
    Database database = await _initDatabase();
    await database.insert(
      'cronometros',
      cronometro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Cronometro agendado"); 
    database.close();
  }

  //Delete database
Future<void> deleteCronometro(int id) async {

  print(id);
  final db = await _initDatabase();
  await db.delete(
    'cronometros',
    where: "id = ?",
    whereArgs: [id],
  );
}

  Future<void> eliminarDatabase() async{
    print("delete");
    String path = join( await getDatabasesPath(), 'easy.db');
    await deleteDatabase(path);
  }
}

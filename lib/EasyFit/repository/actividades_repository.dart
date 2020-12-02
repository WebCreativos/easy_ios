import 'dart:async';
import 'dart:io';

import 'package:easygymclub/EasyFit/models/actividades.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ActividadesRepository {

  Database _database;



  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "actividadesss.db");
    return await openDatabase(
        path,
        onCreate: (db, version) {
          print("Creating database");
          return db.execute(''' 
          create table actividades(id INTEGER PRIMARY KEY, id_usuario INTEGER,intensidad INTEGER, minutos INTEGER, fecha INTEGER, actividad TEXT, calorias TEXT)
          '''
          ); // campo => hora 
        },
        version: 2
    );

  }
 
  Future < List < Map >> actividadesList() async {
    final Database db = await _initDatabase(); 
    final List < Map < String, dynamic >> maps = await db.query('actividades');
    List<Map> actividades;
    actividades = List.generate(maps.length, (i) {
      print(maps);
      return maps[i];
    });
    return actividades;
  }

  Future<void> saveActividad(Actividades actividad) async {
    UserModel user =  await User.getSavedUser();
    actividad.setidUsuario(user.pk);
    actividad.setCalorias(caloriasActividad(actividad.intensidad,actividad.minutos,actividad.actividad));
    Database database = await _initDatabase();
    await database.insert(
      'actividades',
      actividad.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    database.close();
  }

  Future<void> deleteActividad(int id) async {
    Database database = await _initDatabase();
    await database.delete('actividades', where: 'id = ?', whereArgs: [id]);
    database.close();
  }

  //Delete database

  Future<void> eliminarDatabase() async{
    print("delete");
    String path = join( await getDatabasesPath(), 'easy.db');
    await deleteDatabase(path);
  }
  double caloriasActividad(int intensidad, int minutos, String actividad){
    double calorias;
    double aumentoIntesidad;
    switch(actividad){
      case "Correr":
         calorias = 15.7;
        break;
      case "Caminar":
         calorias = 5.4;
        break;
      case "Ciclismo":
         calorias = 7.4;
        break;
      case "Natacion":
         calorias = 12;
        break;
      case "Levantamiento de pesas":
         calorias = 8;
        break;
    }
    switch (intensidad) {
      case 1: aumentoIntesidad = 1;
      break;
      case 2: aumentoIntesidad = 1.5;
      break;
      case 3: aumentoIntesidad = 2;
      break;

    }
    return (calorias*minutos)*aumentoIntesidad;
  }
}

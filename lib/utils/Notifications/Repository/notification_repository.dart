import 'package:background_fetch/background_fetch.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class NotificationRepository  {



  NotificationRepository() {
    this._startBackground();
  } 
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "easyadb.db");
    return await openDatabase(
        path,
        onCreate: (db, version) {
          print("Creating database");
          return db.execute(''' 
          create table notifications(id INTEGER PRIMARY KEY, id_usuario INTEGER, content TEXT, hour TEXT)
          '''
          ); // campo => hora 
        },
        version: 1
    );

  }

  Future<void> saveNotification(String content, String hour) async {
    Map<String,dynamic> saveNotification = {
      "content":content,
      "hour":hour,
      "id":1
    };
    print(saveNotification);
    Database database = await _initDatabase();
    await database.insert(
      'notifications',
      saveNotification,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Notification agendado"); 
  }

  Future < List < Map >> notificationsList() async {
    final Database db = await _initDatabase(); 
    final List < Map < String, dynamic >> maps = await db.query('notifications');
    List<Map> cronometros;
    cronometros = List.generate(maps.length, (i) {
      return maps[i];
    });
    print("lista notifications");
    return cronometros;
  }

  Future < void > _startBackground() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      stopOnTerminate: false,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE

    ), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      print(new DateTime.now());
      // IMPORTANT: You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });
    BackgroundFetch.start().then((int status) {
      print('[BackgroundFetch] start success: $status');
    });
  }
}
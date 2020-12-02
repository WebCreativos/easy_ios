import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easygymclub/EasyFit/models/cronometro.dart';

class CronometrosDB {
  var database;
  void createDb() async {
    print(join(await getDatabasesPath(), 'easy.db')); 
    database = openDatabase(
      'easy.db',
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "create table cronometros(id int not null primary key, idUsuario int not null, pasos int not null, calorias int not null);",
        );
      }, 
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
  Future < void > insertCronometro(Cronometro cronometro) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'cronometros',
      cronometro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future < List < Cronometro >> cronometrosList() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List < Map < String, dynamic >> maps = await db.query('cronometros');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Cronometro(
        pasos: maps[i]['pasos'],
        calorias: maps[i]['calorias'],
      );
    });
  }

  Future < void > updateCronometros(Cronometro cronometro, int id) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'cronometros',
      cronometro.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future < void > deleteCronometro(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'cronometros',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }



}
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shiny_chances/Model/pokemon.dart';

class DatabaseHelper {
  final _databaseName = 'dynamax.db';
  final _databaseVersion = 1;

  final legendaryTable = 'legendary_table';
  final normalTable = 'normal_table';

  final columnId = '_id';
  final columnName = 'name';
  final columnCaught = 'caught';
  final columnFileName = 'file_name';

  DatabaseHelper._privateConstructor() {
    initDatabase();
    print('DatabaseHelper constructor finished');
  }

  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  static Database _database;

  factory DatabaseHelper() {
    return _instance;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    print('database initialized');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $legendaryTable(
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnFileName TEXT NOT NULL,
    $columnCaught INTEGER NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE $normalTable(
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnFileName TEXT NOT NULL,
    $columnCaught INTEGER NOT NULL
    ''');
  }

  Future<void> insert(Pokemon pokemon, String table) async {
    await _database.insert(table, pokemon.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Pokemon>> getLegendaries() async {
    return await _getPokemon(legendaryTable);
  }

  Future<List<Pokemon>> getNormalPokemon() async {
    return await _getPokemon(normalTable);
  }

  Future<List<Pokemon>> _getPokemon(String table) async {
    final List<Map<String, dynamic>> maps = await _database.query(table);
    return List.generate(maps.length, (i) {
      return Pokemon(
        idNumber: maps[i]['_id'],
        name: maps[i]['name'],
        fileName: maps[i]['file_name'],
        caught: maps[i]['caught'],
      );
    });
  }

  Future<void> updatePokemon(Pokemon pokemon, String table) async {
    await _database.update(
      table,
      pokemon.toMap(),
      where: "_id = ?",
      whereArgs: [pokemon.idNumber],
    );
  }
}

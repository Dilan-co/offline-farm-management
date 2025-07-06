import 'dart:async';

import 'package:farm_management/database/farm_management_db.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
//   final StateController stateController = Get.find();

//   Future<Database> get database async {
//     // Debug print to check if the database is null
//     debugPrint("_database is null: ${stateController.getDatabase() == null}");
//     if (stateController.getDatabase() != null &&
//         stateController.getDatabase()!.isOpen) {
//       debugPrint("Database Exists");
//       return stateController.getDatabase();
//     } else {
//       // try {
//       Database database;
//       database = await initializeDatabase();
//       stateController.setDatabase(database);
//       debugPrint("Database Initialized");
//       return database;
//       // } catch (e) {
//       //   debugPrint("Error initializing database: $e");
//       //   rethrow;
//       // }
//     }
//   }
// }

  static Database? _database;
  static final _initCompleter = Completer<Database>();

  Future<Database> get database async {
    if (_database != null) return _database!;
    if (!_initCompleter.isCompleted) {
      _initCompleter.complete(initializeDatabase());
    }
    _database = await _initCompleter.future;
    return _database!;
  }

  Future<String> get fullPath async {
    const dbName = "farm_management.db";
    final path = await getDatabasesPath();
    return join(path, dbName);
  }

  Future<Database> initializeDatabase() async {
    final path = await fullPath;
    return await openDatabase(
      path,
      version: 1,
      onCreate: createDatabase,
      onOpen: (db) async {
        debugPrint("Database opened successfully.");
      },
      singleInstance: true,
    );
  }

  Future<void> createDatabase(Database database, int version) async {
    try {
      //Enable Foreign Keys
      await database.execute('PRAGMA foreign_keys = ON;');
      await FarmManagementDB().createTables(database: database);
      debugPrint("Tables created successfully.");
    } catch (e) {
      debugPrint("Error creating tables: $e");
      rethrow;
    }
  }
}

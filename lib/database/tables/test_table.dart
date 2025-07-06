import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farm_management/models/table_models/test_table_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class TestTable {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'testTable';

  
  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "user_id" INTEGER,
      "first_name" TEXT NOT NULL,
      "last_name" TEXT,
      "city" TEXT NOT NULL,
      "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE NO ACTION ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required String firstName,
      required String lastName,
      required String city}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "first_name": firstName,
      "last_name": lastName,
      "city": city,
      "created_at": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      //Format (2024-09-28 10:35:31)
    });
  }

  Future<List<TestTableModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(id, first_name, last_name, city, created_at);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => TestTableModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<TestTableModel> fetchById({required int id}) async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE id = ?""", [id]);

    debugPrint("fetchById Done");

    return TestTableModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<TestTableModel>>
    // return data.map((data) => TestTableModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required int id,
      required String firstName,
      String? lastName,
      required String city}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "first_name": firstName,
        if (lastName != null) "last_name": lastName,
        "city": city,
        "created_at": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        //Format (2024-09-28 10:35:31)
      },
      where: "id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }
}

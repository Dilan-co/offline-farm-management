import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class FinishedProductSizeCheckHourly {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_finished_product_size_check_hourly';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "finished_product_size_check_hourly_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "variety" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "hourly_size_check" TEXT DEFAULT NULL,
      "measurement_unit" TEXT NOT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER NOT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("finished_product_size_check_hourly_id" AUTOINCREMENT)
    );""");
  }

  Future<int> createRecord(
      {required FinishedProductSizeCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "finished_product_size_check_hourly_id":
          model.finishedProductSizeCheckHourlyId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "variety": model.variety,
      "date": model.date,
      "hourly_size_check": model.hourlySizeCheck,
      "measurement_unit": model.measurementUnit,
      "comment": model.comment,
      "user_id": model.userId,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "signature": model.signature,
      "is_synced": model.isSynced,
      "delete_date": model.deleteDate,
    });
  }

  Future<List<FinishedProductSizeCheckHourlyModel>>
      fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) =>
            FinishedProductSizeCheckHourlyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<FinishedProductSizeCheckHourlyModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(finished_product_size_check_hourly_id, client, farm, crop, variety, date, hourly_size_check, measurement_unit, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) =>
            FinishedProductSizeCheckHourlyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<FinishedProductSizeCheckHourlyModel> fetchById(
      {required int finishedProductSizeCheckHourlyId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE finished_product_size_check_hourly_id = ?""",
        [finishedProductSizeCheckHourlyId]);

    debugPrint("fetchById Done");

    return FinishedProductSizeCheckHourlyModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<FinishedProductSizeCheckHourlyModel>>
    // return data.map((data) => FinishedProductSizeCheckHourlyModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required FinishedProductSizeCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "finished_product_size_check_hourly_id":
            model.finishedProductSizeCheckHourlyId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "variety": model.variety,
        "date": model.date,
        "hourly_size_check": model.hourlySizeCheck,
        "measurement_unit": model.measurementUnit,
        "comment": model.comment,
        "user_id": model.userId,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "signature": model.signature,
        "is_synced": model.isSynced,
        "delete_date": model.deleteDate,
      },
      where: "finished_product_size_check_hourly_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.finishedProductSizeCheckHourlyId],
    );
  }

  Future<int> deleteRecord(
      {required FinishedProductSizeCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "finished_product_size_check_hourly_id = ?",
        whereArgs: [model.finishedProductSizeCheckHourlyId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }

  Future<int> deleteExpiredRecords() async {
    final database = await DatabaseService().database;
    // Current date in YYYY-MM-DD format
    String today = DateTime.now().toString().split(' ')[0];
    // Raw SQL query to delete expired records
    int result = await database.rawDelete(
      """DELETE FROM $tableName WHERE date(delete_date) < date(?)""",
      [today],
    );
    debugPrint("deleteExpiredRecords Done --> $result");
    return result;
  }
}

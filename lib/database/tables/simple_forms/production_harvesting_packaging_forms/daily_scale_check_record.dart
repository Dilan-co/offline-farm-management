import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DailyScaleCheck {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_daily_scale_check';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "daily_scale_check_id" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "line_number" TEXT DEFAULT NULL,
      "scale_name" TEXT NOT NULL,
      "five_point_check" TEXT NOT NULL,
      "test_mass_weight" TEXT NOT NULL,
      "scale_reading" TEXT NOT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("daily_scale_check_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord({required DailyScaleCheckModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "daily_scale_check_id": model.dailyScaleCheckId,
      "date": model.date,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "line_number": model.lineNumber,
      "scale_name": model.scaleName,
      "five_point_check": model.fivePointCheck,
      "test_mass_weight": model.testMassWeight,
      "scale_reading": model.scaleReading,
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

  Future<List<DailyScaleCheckModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => DailyScaleCheckModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<DailyScaleCheckModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(daily_scale_check_id, date, client, farm, crop, line_number, scale_name, five_point_check, test_mass_weight, scale_reading, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => DailyScaleCheckModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<DailyScaleCheckModel> fetchById(
      {required int dailyScaleCheckId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE daily_scale_check_id = ?""",
        [dailyScaleCheckId]);

    debugPrint("fetchById Done");

    return DailyScaleCheckModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<DailyScaleCheckModel>>
    // return data.map((data) => DailyScaleCheckModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required DailyScaleCheckModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "daily_scale_check_id": model.dailyScaleCheckId,
        "date": model.date,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "line_number": model.lineNumber,
        "scale_name": model.scaleName,
        "five_point_check": model.fivePointCheck,
        "test_mass_weight": model.testMassWeight,
        "scale_reading": model.scaleReading,
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
      where: "daily_scale_check_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.dailyScaleCheckId],
    );
  }

  Future<int> deleteRecord({required DailyScaleCheckModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "daily_scale_check_id = ?",
        whereArgs: [model.dailyScaleCheckId]);

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

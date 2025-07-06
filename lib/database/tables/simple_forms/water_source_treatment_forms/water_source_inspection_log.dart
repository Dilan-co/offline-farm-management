import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/water_source_treatment_forms/water_source_inspection_log_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class WaterSourceInspectionLog {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_water_source_inspection_log';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "water_source_inspection_log_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER DEFAULT NULL,
      "date" TEXT NOT NULL,
      "water_source_name" TEXT NOT NULL,
      "is_secure" INTEGER NOT NULL DEFAULT 0,
      "is_authorized_access_permitted" INTEGER NOT NULL DEFAULT 0,
      "is_free_from_contamination" INTEGER NOT NULL DEFAULT 0,
      "media" TEXT DEFAULT NULL,
      "corrective_action" TEXT DEFAULT NULL,
      "comment" TEXT DEFAULT NULL,
      "deleted" INTEGER NOT NULL DEFAULT 0,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("water_source_inspection_log_id" AUTOINCREMENT),
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required WaterSourceInspectionLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "water_source_inspection_log_id": model.waterSourceInspectionLogId,
      "client": model.client,
      "farm": model.farm,
      "date": model.date,
      "water_source_name": model.waterSourceName,
      "is_secure": model.isSecure,
      "is_authorized_access_permitted": model.isAuthorizedAccessPermitted,
      "is_free_from_contamination": model.isFreeFromContamination,
      "media": model.media,
      "corrective_action": model.correctiveAction,
      "comment": model.comment,
      "deleted": model.deleted,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "is_synced": model.isSynced,
      "delete_date": model.deleteDate,
    });
  }

  Future<List<WaterSourceInspectionLogModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => WaterSourceInspectionLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<WaterSourceInspectionLogModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(water_source_inspection_log_id, client, farm, date, water_source_name, is_secure, is_authorized_access_permitted, is_free_from_contamination, media, corrective_action, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => WaterSourceInspectionLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<WaterSourceInspectionLogModel> fetchById(
      {required int waterSourceInspectionLogId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE water_source_inspection_log_id = ?""",
        [waterSourceInspectionLogId]);

    debugPrint("fetchById Done");

    return WaterSourceInspectionLogModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<WaterSourceInspectionLogModel>>
    // return data.map((data) => WaterSourceInspectionLogModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required WaterSourceInspectionLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "water_source_inspection_log_id": model.waterSourceInspectionLogId,
        "client": model.client,
        "farm": model.farm,
        "date": model.date,
        "water_source_name": model.waterSourceName,
        "is_secure": model.isSecure,
        "is_authorized_access_permitted": model.isAuthorizedAccessPermitted,
        "is_free_from_contamination": model.isFreeFromContamination,
        "media": model.media,
        "corrective_action": model.correctiveAction,
        "comment": model.comment,
        "deleted": model.deleted,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "is_synced": model.isSynced,
        "delete_date": model.deleteDate,
      },
      where: "water_source_inspection_log_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.waterSourceInspectionLogId],
    );
  }

  Future<int> deleteRecord(
      {required WaterSourceInspectionLogModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "water_source_inspection_log_id = ?",
        whereArgs: [model.waterSourceInspectionLogId]);

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

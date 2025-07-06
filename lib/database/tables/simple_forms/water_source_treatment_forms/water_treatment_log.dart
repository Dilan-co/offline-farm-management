import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/water_source_treatment_forms/water_treatment_log_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class WaterTreatmentLog {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_water_treatment_log';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "water_treatment_log_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "description" TEXT DEFAULT NULL,
      "is_according_to_water_treatment_work_instruction" INTEGER NOT NULL DEFAULT 0,
      "is_treatment_effective" INTEGER NOT NULL DEFAULT 0,
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
      PRIMARY KEY("water_treatment_log_id" AUTOINCREMENT),
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord({required WaterTreatmentLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "water_treatment_log_id": model.waterTreatmentLogId,
      "client": model.client,
      "farm": model.farm,
      "date": model.date,
      "description": model.description,
      "is_according_to_water_treatment_work_instruction":
          model.isAccordingToWaterTreatmentWorkInstruction,
      "is_treatment_effective": model.isTreatmentEffective,
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

  Future<List<WaterTreatmentLogModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => WaterTreatmentLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<WaterTreatmentLogModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(water_treatment_log_id, client, farm, date, description, is_according_to_water_treatment_work_instruction, is_treatment_effective, media, corrective_action, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => WaterTreatmentLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<WaterTreatmentLogModel> fetchById(
      {required int waterTreatmentLogId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE water_treatment_log_id = ?""",
        [waterTreatmentLogId]);

    debugPrint("fetchById Done");

    return WaterTreatmentLogModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<WaterTreatmentLogModel>>
    // return data.map((data) => WaterTreatmentLogModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required WaterTreatmentLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "water_treatment_log_id": model.waterTreatmentLogId,
        "client": model.client,
        "farm": model.farm,
        "date": model.date,
        "description": model.description,
        "is_according_to_water_treatment_work_instruction":
            model.isAccordingToWaterTreatmentWorkInstruction,
        "is_treatment_effective": model.isTreatmentEffective,
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
      where: "water_treatment_log_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.waterTreatmentLogId],
    );
  }

  Future<int> deleteRecord({required WaterTreatmentLogModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "water_treatment_log_id = ?",
        whereArgs: [model.waterTreatmentLogId]);

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

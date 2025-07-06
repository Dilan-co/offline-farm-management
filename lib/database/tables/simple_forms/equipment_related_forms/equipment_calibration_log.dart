import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/equipment_related_forms/equipment_calibration_log_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class EquipmentCalibrationLog {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_equipment_calibration_log';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "equipment_calibration_log_id" INTEGER NOT NULL,
      "equipment_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      "method_of_calibration" TEXT NOT NULL,
      "reading" TEXT DEFAULT NULL,
      "is_calibration_satisfactory" INTEGER NOT NULL DEFAULT 1,
      "media" TEXT NOT NULL,
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
      PRIMARY KEY("equipment_calibration_log_id" AUTOINCREMENT),
      FOREIGN KEY (equipment_id) REFERENCES ORG_equipment (equipment_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required EquipmentCalibrationLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "equipment_calibration_log_id": model.equipmentCalibrationLogId,
      "equipment_id": model.equipmentId,
      "client": model.client,
      "date": model.date,
      "method_of_calibration": model.methodOfCalibration,
      "reading": model.reading,
      "is_calibration_satisfactory": model.isCalibrationSatisfactory,
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

  Future<List<EquipmentCalibrationLogModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => EquipmentCalibrationLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<EquipmentCalibrationLogModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(equipment_calibration_log_id, equipment_id, client, date, method_of_calibration, reading, is_calibration_satisfactory, media, corrective_action, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => EquipmentCalibrationLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<EquipmentCalibrationLogModel> fetchById(
      {required int equipmentCalibrationLogId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE equipment_calibration_log_id = ?""",
        [equipmentCalibrationLogId]);

    debugPrint("fetchById Done");

    return EquipmentCalibrationLogModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<EquipmentCalibrationLogModel>>
    // return data.map((data) => EquipmentCalibrationLogModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required EquipmentCalibrationLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "equipment_calibration_log_id": model.equipmentCalibrationLogId,
        "equipment_id": model.equipmentId,
        "client": model.client,
        "date": model.date,
        "method_of_calibration": model.methodOfCalibration,
        "reading": model.reading,
        "is_calibration_satisfactory": model.isCalibrationSatisfactory,
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
      where: "equipment_calibration_log_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.equipmentCalibrationLogId],
    );
  }

  Future<int> deleteRecord(
      {required EquipmentCalibrationLogModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "equipment_calibration_log_id = ?",
        whereArgs: [model.equipmentCalibrationLogId]);

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

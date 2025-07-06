import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/equipment_related_forms/equipment_maintenance_log_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class EquipmentMaintenanceLog {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_equipment_maintenance_log';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "equipment_maintenance_log_id" INTEGER NOT NULL,
      "equipment_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "problem" TEXT DEFAULT NULL,
      "priority" TEXT DEFAULT NULL,
      "date_identified" TEXT DEFAULT NULL,
      "date_maintenance" TEXT DEFAULT NULL,
      "media" TEXT DEFAULT NULL,
      "action_taken" TEXT DEFAULT NULL,
      "external_contractor" TEXT DEFAULT NULL,
      "external_contractor_details" TEXT DEFAULT NULL,
      "date_completed" TEXT DEFAULT NULL,
      "equipment_cleaned" TEXT DEFAULT NULL,
      "area_released_by" TEXT DEFAULT NULL,
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
      PRIMARY KEY("equipment_maintenance_log_id" AUTOINCREMENT),
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (equipment_id) REFERENCES ORG_equipment (equipment_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required EquipmentMaintenanceLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "equipment_maintenance_log_id": model.equipmentMaintenanceLogId,
      "equipment_id": model.equipmentId,
      "client": model.client,
      "problem": model.problem,
      "priority": model.priority,
      "date_identified": model.dateIdentified,
      "date_maintenance": model.dateMaintenance,
      "media": model.media,
      "action_taken": model.actionTaken,
      "external_contractor": model.externalContractor,
      "external_contractor_details": model.externalContractorDetails,
      "date_completed": model.dateCompleted,
      "equipment_cleaned": model.equipmentCleaned,
      "area_released_by": model.areaReleasedBy,
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

  Future<List<EquipmentMaintenanceLogModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => EquipmentMaintenanceLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<EquipmentMaintenanceLogModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(equipment_maintenance_log_id, equipment_id, client, problem, priority, date_identified, date_maintenance, action_taken, external_contractor, date_completed, equipment_cleaned, area_released_by, corrective_action, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => EquipmentMaintenanceLogModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<EquipmentMaintenanceLogModel> fetchById(
      {required int equipmentMaintenanceLogId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE equipment_maintenance_log_id = ?""",
        [equipmentMaintenanceLogId]);

    debugPrint("fetchById Done");

    return EquipmentMaintenanceLogModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<EquipmentMaintenanceLogModel>>
    // return data.map((data) => EquipmentMaintenanceLogModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required EquipmentMaintenanceLogModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "equipment_maintenance_log_id": model.equipmentMaintenanceLogId,
        "equipment_id": model.equipmentId,
        "client": model.client,
        "problem": model.problem,
        "priority": model.priority,
        "date_identified": model.dateIdentified,
        "date_maintenance": model.dateMaintenance,
        "media": model.media,
        "action_taken": model.actionTaken,
        "external_contractor": model.externalContractor,
        "external_contractor_details": model.externalContractorDetails,
        "date_completed": model.dateCompleted,
        "equipment_cleaned": model.equipmentCleaned,
        "area_released_by": model.areaReleasedBy,
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
      where: "equipment_maintenance_log_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.equipmentMaintenanceLogId],
    );
  }

  Future<int> deleteRecord(
      {required EquipmentMaintenanceLogModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "equipment_maintenance_log_id = ?",
        whereArgs: [model.equipmentMaintenanceLogId]);

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

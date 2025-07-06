import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_equipment_type_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgEquipmentType {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_equipment_type';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "equipment_type_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "description" TEXT DEFAULT NULL,
      "status" INTEGER NOT NULL DEFAULT 1,
      "deleted" INTEGER NOT NULL DEFAULT 0,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("equipment_type_id" AUTOINCREMENT)
    );""");
  }

  Future<void> createRecordsBatch(
      {required List<OrgEquipmentTypeModel> models}) async {
    final database = await DatabaseService().database;
    List<OrgEquipmentTypeModel> insertList = [];
    List<OrgEquipmentTypeModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT equipment_type_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['equipment_type_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.equipmentTypeId)) {
        updateList.add(record);
      } else {
        insertList.add(record);
      }
    }

    await database.transaction((txn) async {
      final batch = txn.batch();

      // Step 2: Insert records
      if (insertList.isNotEmpty) {
        for (var model in insertList) {
          batch.insert(tableName, {
            "equipment_type_id": model.equipmentTypeId,
            "name": model.name,
            "description": model.description,
            "status": model.status,
            "deleted": model.deleted,
            "is_synced": model.isSynced,
          });
        }
      }
      // Step 3: Update records
      if (updateList.isNotEmpty) {
        for (var model in updateList) {
          batch.update(
            tableName,
            {
              "equipment_type_id": model.equipmentTypeId,
              "name": model.name,
              "description": model.description,
              "status": model.status,
              "deleted": model.deleted,
              "is_synced": model.isSynced,
            },
            where: "equipment_type_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.equipmentTypeId],
          );
        }
      }
      // Use `noResult: true` if results for each operation not needed
      final results = await batch.commit(noResult: false);

      // Results will contain row IDs of inserted records
      debugPrint("Batch insert completed. Results: $results");
      debugPrint("Batch insert completed for ${results.length} records.");
    });
  }

  Future<int> createRecord({required OrgEquipmentTypeModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "equipment_type_id": model.equipmentTypeId,
      "name": model.name,
      "description": model.description,
      "status": model.status,
      "deleted": model.deleted,
      "is_synced": model.isSynced,
    });
  }

  Future<List<OrgEquipmentTypeModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(equipment_type_id, name, description, status, deleted, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgEquipmentTypeModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgEquipmentTypeModel> fetchById(
      {required int equipmentTypeId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE equipment_type_id = ?""",
        [equipmentTypeId]);

    debugPrint("fetchById Done");

    return OrgEquipmentTypeModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgEquipmentTypeModel>>
    // return data.map((data) => OrgEquipmentTypeModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required OrgEquipmentTypeModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "equipment_type_id": model.equipmentTypeId,
        "name": model.name,
        "description": model.description,
        "status": model.status,
        "deleted": model.deleted,
        "is_synced": model.isSynced,
      },
      where: "equipment_type_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.equipmentTypeId],
    );
  }

  Future<int> deleteRecord({required OrgEquipmentTypeModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "equipment_type_id = ?", whereArgs: [model.equipmentTypeId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

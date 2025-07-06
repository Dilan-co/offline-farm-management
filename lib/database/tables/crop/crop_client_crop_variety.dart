import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_variety_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class CropClientCropVariety {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'CROP_client_crop_variety';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "client_crop_variety_id" INTEGER NOT NULL,
      "client_crop_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "code" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("client_crop_variety_id" AUTOINCREMENT)
    );""");
    int index = await addRecords();

    debugPrint("CROP_client_crop_variety addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;

    try {
      // Generate the SQL query dynamically
      String query =
          """INSERT INTO $tableName (client_crop_variety_id, client_crop_id, name, code, created_by, updated_by, created_at, updated_at, signature) VALUES 
        (1, 19, 'APL-G1', 'APL-G1', 3, 3, '2024-06-08 06:46:09', '2024-06-08 06:46:09', NULL),
        (2, 19, 'test variety', '900961', 3, 3, '2024-06-09 03:58:41', '2024-06-09 03:58:41', NULL),
        (3, 20, 'Green Apple', 'G-001', 3, 3, '2024-06-09 04:42:54', '2024-06-09 04:42:54', NULL),
        (4, 19, 'Green Apple', 'G-001', 3, 3, '2024-06-09 04:44:25', '2024-06-09 04:44:25', NULL),
        (5, 21, 'Calypso', 'ABC1', 3, 3, '2024-09-27 20:23:49', '2024-09-27 20:23:49', NULL);""";

      debugPrint("CROP_client_crop_variety addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint('Error adding data to CROP_client_crop_variety: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch(
      {required List<CropClientCropVarietyModel> models}) async {
    final database = await DatabaseService().database;
    List<CropClientCropVarietyModel> insertList = [];
    List<CropClientCropVarietyModel> updateList = [];
    // Fetch all IDs from the database
    final existingData = await database
        .rawQuery("""SELECT client_crop_variety_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['client_crop_variety_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.clientCropVarietyId)) {
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
            "client_crop_variety_id": model.clientCropVarietyId,
            "client_crop_id": model.clientCropId,
            "name": model.name,
            "code": model.code,
            "created_by": model.createdBy,
            "updated_by": model.updatedBy,
            "created_at": model.createdAt,
            "updated_at": model.updatedAt,
            "signature": model.signature,
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
              "client_crop_variety_id": model.clientCropVarietyId,
              "client_crop_id": model.clientCropId,
              "name": model.name,
              "code": model.code,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "signature": model.signature,
              "is_synced": model.isSynced,
            },
            where: "client_crop_variety_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.clientCropVarietyId],
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

  Future<int> createRecord({required CropClientCropVarietyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "client_crop_variety_id": model.clientCropVarietyId,
      "client_crop_id": model.clientCropId,
      "name": model.name,
      "code": model.code,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "signature": model.signature,
      "is_synced": model.isSynced,
    });
  }

  Future<List<CropClientCropVarietyModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(client_crop_variety_id, client_crop_id, name, code, created_by, updated_by, created_at, updated_at, signature, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => CropClientCropVarietyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<CropClientCropVarietyModel> fetchByVarietyId(
      {required int varietyId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_crop_variety_id = ?""",
        [varietyId]);

    debugPrint("fetchById Done");

    return CropClientCropVarietyModel.fromSqfliteDatabase(data.first);
  }

  Future<List<CropClientCropVarietyModel>> fetchByClientCropId(
      {required int clientCropId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_crop_id = ?""",
        [clientCropId]);

    debugPrint("fetchById Done");

    // return CropClientCropVarietyModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<CropClientCropVarietyModel>>
    return data
        .map((data) => CropClientCropVarietyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<int> updateRecord({required CropClientCropVarietyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "client_crop_variety_id": model.clientCropVarietyId,
        "client_crop_id": model.clientCropId,
        "name": model.name,
        "code": model.code,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "signature": model.signature,
        "is_synced": model.isSynced,
      },
      where: "client_crop_variety_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.clientCropVarietyId],
    );
  }

  Future<int> deleteRecord({required CropClientCropVarietyModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "client_crop_variety_id = ?",
        whereArgs: [model.clientCropVarietyId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

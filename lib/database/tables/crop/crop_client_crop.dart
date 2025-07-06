import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class CropClientCrop {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'CROP_client_crop';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "client_crop_id" INTEGER NOT NULL,
      "client_id" INTEGER NOT NULL,
      "crop_id" INTEGER NOT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("client_crop_id" AUTOINCREMENT),
      FOREIGN KEY (client_id) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop_id) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE
    );""");
    // int index = await addRecords();

    // debugPrint("CROP_client_crop addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;

    try {
      // Generate the SQL query dynamically
      String query =
          """INSERT INTO $tableName (client_crop_id, client_id, crop_id, created_at, updated_at, created_by, updated_by, created_by_signature, signature) VALUES 
        (19, 10, 19, '2024-04-22 23:23:57', '2024-09-12 00:27:49', 3, 3, NULL, NULL),
        (20, 10, 20, '2024-04-29 22:18:50', '2024-04-29 22:18:50', 3, 3, NULL, NULL),
        (21, 10, 21, '2024-09-27 20:23:04', '2024-09-27 20:23:04', 3, 3, NULL, NULL);""";

      debugPrint("CROP_client_crop addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint('Error adding data to CROP_client_crop: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch(
      {required List<CropClientCropModel> models}) async {
    final database = await DatabaseService().database;
    List<CropClientCropModel> insertList = [];
    List<CropClientCropModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT client_crop_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['client_crop_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.clientCropId)) {
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
            "client_crop_id": model.clientCropId,
            "client_id": model.clientId,
            "crop_id": model.cropId,
            "created_at": model.createdAt,
            "updated_at": model.updatedAt,
            "created_by": model.createdBy,
            "updated_by": model.updatedBy,
            "created_by_signature": model.createdBySignature,
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
              "client_crop_id": model.clientCropId,
              "client_id": model.clientId,
              "crop_id": model.cropId,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_by_signature": model.createdBySignature,
              "signature": model.signature,
              "is_synced": model.isSynced,
            },
            where: "client_crop_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.clientCropId],
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

  Future<int> createRecord({required CropClientCropModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "client_crop_id": model.clientCropId,
      "client_id": model.clientId,
      "crop_id": model.cropId,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "is_synced": model.isSynced,
    });
  }

  Future<List<CropClientCropModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(client_crop_id, client_id, crop_id, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => CropClientCropModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<CropClientCropModel> fetchById({required int clientCropId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_crop_id = ?""",
        [clientCropId]);

    debugPrint("fetchById Done");

    return CropClientCropModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<CropClientCropModel>>
    // return data.map((data) => CropClientCropModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<CropClientCropModel?> fetchByCropId({required int cropId}) async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE crop_id = ?""", [cropId]);

    debugPrint("fetchById Done");

    if (data.isNotEmpty) {
      return CropClientCropModel.fromSqfliteDatabase(data.first);
    } else {
      return null;
    }
  }

  Future<int> updateRecord({required CropClientCropModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "client_crop_id": model.clientCropId,
        "client_id": model.clientId,
        "crop_id": model.cropId,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "is_synced": model.isSynced,
      },
      where: "client_crop_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.clientCropId],
    );
  }

  Future<int> deleteRecord({required CropClientCropModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "client_crop_id = ?", whereArgs: [model.clientCropId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

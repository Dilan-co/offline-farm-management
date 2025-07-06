import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/crop/crop_crop_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class CropCrop {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'CROP_crop';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "crop_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("crop_id" AUTOINCREMENT)
    );""");
    // int index = await addRecords();

    // debugPrint("CROP_crop addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;
    try {
      // List of records to insert
      List<Map<String, dynamic>> records = [
        {'crop_id': 19, 'name': 'Apples'},
        {'crop_id': 20, 'name': 'Lettuce'},
        {'crop_id': 21, 'name': 'Mango'},
        // Add more records as needed
      ];

      // Generate the values for the SQL query dynamically
      String values = records.map((record) {
        return "(${record['crop_id']}, '${record['name']}')";
      }).join(", ");

      // Generate the SQL query dynamically
      String query = "INSERT INTO $tableName (crop_id, name) VALUES $values";

      debugPrint("CROP_crop addRecords Done");
      return await database.rawInsert(query);

      // debugPrint("CROP_crop addRecords Done");

      // return await database
      //     .rawInsert("""INSERT INTO $tableName (crop_id, name) VALUES
      //   (19, 'Apples'),
      //   (20, 'Lettuce'),
      //   (21, 'Mango')""");
    } catch (e) {
      debugPrint('Error adding data to CROP_crop: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch({required List<CropCropModel> models}) async {
    final database = await DatabaseService().database;
    List<CropCropModel> insertList = [];
    List<CropCropModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT crop_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['crop_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.cropId)) {
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
            "crop_id": model.cropId,
            "name": model.name,
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
              "crop_id": model.cropId,
              "name": model.name,
              "is_synced": model.isSynced,
            },
            where: "crop_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.cropId],
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

  Future<int> createRecord({required CropCropModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "crop_id": model.cropId,
      "name": model.name,
      "is_synced": model.isSynced,
    });
  }

  Future<List<CropCropModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(crop_id, name, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data.map((data) => CropCropModel.fromSqfliteDatabase(data)).toList();
  }

  Future<CropCropModel> fetchById(int cropId) async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE crop_id = ?""", [cropId]);

    debugPrint("fetchById Done");

    return CropCropModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<CropCropModel>>
    // return data.map((data) => CropCropModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required CropCropModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "crop_id": model.cropId,
        "name": model.name,
        "is_synced": model.isSynced,
      },
      where: "crop_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.cropId],
    );
  }

  Future<int> deleteRecord({required CropCropModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database
        .delete(tableName, where: "crop_id = ?", whereArgs: [model.cropId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

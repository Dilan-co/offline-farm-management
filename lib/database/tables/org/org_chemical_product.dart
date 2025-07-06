import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_chemical_product_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgChemicalProduct {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_chemical_product';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "chemical_product_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "brand_name" TEXT NOT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "read_only" INTEGER NOT NULL DEFAULT 0, -- Read Only. YES 1, NO 0,
      PRIMARY KEY("chemical_product_id" AUTOINCREMENT)
    );""");
  }

  Future<void> createRecordsBatch(
      {required List<OrgChemicalProductModel> models}) async {
    final database = await DatabaseService().database;
    List<OrgChemicalProductModel> insertList = [];
    List<OrgChemicalProductModel> updateList = [];
    // Fetch all IDs from the database
    final existingData = await database
        .rawQuery("""SELECT chemical_product_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['chemical_product_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.chemicalProductId)) {
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
            "chemical_product_id": model.chemicalProductId,
            "client": model.client,
            "name": model.name,
            "brand_name": model.brandName,
            "is_synced": model.isSynced,
            "read_only": model.readOnly,
          });
        }
      }
      // Step 3: Update records
      if (updateList.isNotEmpty) {
        for (var model in updateList) {
          batch.update(
            tableName,
            {
              "chemical_product_id": model.chemicalProductId,
              "client": model.client,
              "name": model.name,
              "brand_name": model.brandName,
              "is_synced": model.isSynced,
              "read_only": model.readOnly,
            },
            where: "chemical_product_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.chemicalProductId],
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

  Future<int> createRecord({required OrgChemicalProductModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "chemical_product_id": model.chemicalProductId,
      "client": model.client,
      "name": model.name,
      "brand_name": model.brandName,
      "is_synced": model.isSynced,
      "read_only": model.readOnly,
    });
  }

  Future<List<OrgChemicalProductModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(chemical_product_id, client, name, brand_name, is_synced, read_only);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgChemicalProductModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<OrgChemicalProductModel>> fetchAllReadOnlyOrNotRecords(
      {required bool isReadOnlyRecords}) async {
    final database = await DatabaseService().database;
    final isReadOnly = isReadOnlyRecords ? 1 : 0;

    final data = await database.rawQuery(
      "SELECT * FROM $tableName WHERE read_only = ?;",
      [isReadOnly],
    );

    debugPrint("fetchAllReadOnlyOrNotRecords Done");

    return data
        .map((data) => OrgChemicalProductModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgChemicalProductModel> fetchById(
      {required int chemicalProductId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE chemical_product_id = ?""",
        [chemicalProductId]);

    debugPrint("fetchById Done");

    return OrgChemicalProductModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgChemicalProductModel>>
    // return data.map((data) => OrgChemicalProductModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required OrgChemicalProductModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "chemical_product_id": model.chemicalProductId,
        "client": model.client,
        "name": model.name,
        "brand_name": model.brandName,
        "is_synced": model.isSynced,
        "read_only": model.readOnly,
      },
      where: "chemical_product_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.chemicalProductId],
    );
  }

  Future<int> deleteRecord({required OrgChemicalProductModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "chemical_product_id = ?", whereArgs: [model.chemicalProductId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

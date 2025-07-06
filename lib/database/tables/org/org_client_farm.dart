import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_client_farm_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgClientFarm {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_client_farm';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "client_farm_id" INTEGER NOT NULL,
      "client_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "description" TEXT DEFAULT NULL,
      "size" INTEGER DEFAULT NULL,
      "street_no" TEXT DEFAULT NULL,
      "street_name" TEXT DEFAULT NULL,
      "city" TEXT DEFAULT NULL,
      "state" TEXT DEFAULT NULL,
      "postcode" TEXT DEFAULT NULL,
      "country" TEXT DEFAULT NULL,
      "map_coodinates" TEXT DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("client_farm_id" AUTOINCREMENT),
      FOREIGN KEY (client_id) REFERENCES ORG_client (client_id) ON UPDATE CASCADE
    );""");
    // int index = await addRecords();

    // debugPrint("ORG_client_farm addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;

    try {
      // Generate the SQL query dynamically
      String query =
          """INSERT INTO $tableName (client_farm_id, client_id, name, description, size, street_no, street_name, city, state, postcode, country, map_coodinates, created_at, updated_at, created_by, updated_by, created_by_signature, signature) VALUES 
        (12, 10, 'Test Farm', 'Test Farm', 20, '123', 'ABC Street', 'ABC', 'QLD', '4078', 'Australia', '', '2024-04-22 23:23:04', '2024-08-19 09:26:29', 3, 3, NULL, NULL),
        (13, 10, 'Test Farm 2', '2nd Farm', 100, '25', 'Manet Crescent', 'Forest Lake', 'QLD', '4078', 'Australia', '', '2024-09-27 20:16:00', '2024-09-27 20:16:00', 3, 3, NULL, NULL),
        (14, 10, 'Test Farm 3', '3rd Test Farm', 100, '20', 'Manet Crescent', 'Forest Lake', 'QLD', '4078', 'Australia', '', '2024-09-27 20:18:58', '2024-09-27 20:18:58', 3, 3, NULL, NULL),
        (15, 10, 'Katherine Farm', 'Test Farm at Katherine', 100, '25', 'Manet Crescent', 'Forest Lake', 'QLD', '4078', 'Australia', '', '2024-09-27 20:21:28', '2024-09-27 20:28:18', 3, 3, NULL, NULL);""";

      debugPrint("ORG_client_farm addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint('Error adding data to ORG_client_farm: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch(
      {required List<OrgClientFarmModel> models}) async {
    final database = await DatabaseService().database;
    List<OrgClientFarmModel> insertList = [];
    List<OrgClientFarmModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT client_farm_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['client_farm_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.clientFarmId)) {
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
            "client_farm_id": model.clientFarmId,
            "client_id": model.clientId,
            "name": model.name,
            "description": model.description,
            "size": model.size,
            "street_no": model.streetNo,
            "street_name": model.streetName,
            "city": model.city,
            "state": model.state,
            "postcode": model.postCode,
            "country": model.country,
            "map_coodinates": model.mapCoordinates,
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
              "client_farm_id": model.clientFarmId,
              "client_id": model.clientId,
              "name": model.name,
              "description": model.description,
              "size": model.size,
              "street_no": model.streetNo,
              "street_name": model.streetName,
              "city": model.city,
              "state": model.state,
              "postcode": model.postCode,
              "country": model.country,
              "map_coodinates": model.mapCoordinates,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_by_signature": model.createdBySignature,
              "signature": model.signature,
              "is_synced": model.isSynced,
            },
            where: "client_farm_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.clientFarmId],
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

  Future<int> createRecord({required OrgClientFarmModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "client_farm_id": model.clientFarmId,
      "client_id": model.clientId,
      "name": model.name,
      "description": model.description,
      "size": model.size,
      "street_no": model.streetNo,
      "street_name": model.streetName,
      "city": model.city,
      "state": model.state,
      "postcode": model.postCode,
      "country": model.country,
      "map_coodinates": model.mapCoordinates,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "is_synced": model.isSynced,
    });
  }

  Future<List<OrgClientFarmModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(client_farm_id, client_id, name, description, size, street_no, street_name, city, state, postcode, country, map_coodinates, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgClientFarmModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgClientFarmModel> fetchById({required int clientId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_id = ?""", [clientId]);

    debugPrint("fetchById Done");

    return OrgClientFarmModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgClientFarmModel>>
    // return data.map((data) => OrgClientFarmModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required OrgClientFarmModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "client_farm_id": model.clientFarmId,
        "client_id": model.clientId,
        "name": model.name,
        "description": model.description,
        "size": model.size,
        "street_no": model.streetNo,
        "street_name": model.streetName,
        "city": model.city,
        "state": model.state,
        "postcode": model.postCode,
        "country": model.country,
        "map_coodinates": model.mapCoordinates,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "is_synced": model.isSynced,
      },
      where: "client_farm_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.clientFarmId],
    );
  }

  Future<int> deleteRecord({required OrgClientFarmModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "client_farm_id = ?", whereArgs: [model.clientFarmId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

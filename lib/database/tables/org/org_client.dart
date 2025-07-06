import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_client_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgClient {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_client';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "client_id" INTEGER NOT NULL, -- Contains a generated Client ID,
      "client_type_id" INTEGER NOT NULL,
      "name" TEXT DEFAULT NULL, -- Client Name,
      "business_legal_name" TEXT NOT NULL,
      "business_abn" TEXT NOT NULL,
      "is_simple_client" INTEGER NOT NULL DEFAULT 0,
      "status" TEXT DEFAULT NULL, -- Client Status either Active or De Active,
      "email" TEXT DEFAULT NULL, -- Email address for Client,
      "created_date" TEXT DEFAULT NULL, -- Client Created Date,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("client_id" AUTOINCREMENT),
      FOREIGN KEY (client_type_id) REFERENCES ORG_client_type (client_type_id) ON UPDATE CASCADE
    );""");
    // int index = await addRecords();

    // debugPrint("ORG_client addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    try {
      final database = await DatabaseService().database;
      String query =
          """INSERT INTO $tableName (client_id, client_type_id, name, business_legal_name, business_abn, is_simple_client, status, email, created_date, created_at, updated_at, created_by, updated_by, created_by_signature, signature) VALUES
        (10, 3, 'Test Client SM', 'Test Client No. 1', '123456789', 0, 'Active', 'b.blacklock@bigpond.com', NULL, '2024-04-22 23:21:25', '2024-09-27 20:53:13', 3, 3, NULL, NULL);""";

      debugPrint("USER_user addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint("Error adding data to ORG_client: $e");
      return -1; // Return a negative value to indicate an error
    }
  }

  Future<void> createRecordsBatch(
      {required List<OrgClientModel> models}) async {
    final database = await DatabaseService().database;
    List<OrgClientModel> insertList = [];
    List<OrgClientModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT client_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['client_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.clientId)) {
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
            "client_id": model.clientId,
            "client_type_id": model.clientTypeId,
            "name": model.name,
            "business_legal_name": model.businessLegalName,
            "business_abn": model.businessAbn,
            "is_simple_client": model.isSimpleClient,
            "status": model.status,
            "email": model.email,
            "created_date": model.createdDate,
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
              "client_id": model.clientId,
              "client_type_id": model.clientTypeId,
              "name": model.name,
              "business_legal_name": model.businessLegalName,
              "business_abn": model.businessAbn,
              "is_simple_client": model.isSimpleClient,
              "status": model.status,
              "email": model.email,
              "created_date": model.createdDate,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_by_signature": model.createdBySignature,
              "signature": model.signature,
              "is_synced": model.isSynced,
            },
            where: "client_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.clientId],
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

  Future<int> createRecord({required OrgClientModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "client_id": model.clientId,
      "client_type_id": model.clientTypeId,
      "name": model.name,
      "business_legal_name": model.businessLegalName,
      "business_abn": model.businessAbn,
      "is_simple_client": model.isSimpleClient,
      "status": model.status,
      "email": model.email,
      "created_date": model.createdDate,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "is_synced": model.isSynced,
    });
  }

  Future<List<OrgClientModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(client_id, client_type_id, name, business_legal_name, business_abn, is_simple_client, status, email, created_date, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgClientModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgClientModel> fetchByClientId({required int clientId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_id = ?""", [clientId]);

    debugPrint("fetchById Done");

    return OrgClientModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgClientModel>>
    // return data.map((data) => OrgClientModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<OrgClientModel> fetchByClientTypeId(
      {required int clientTypeId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE client_type_id = ?""",
        [clientTypeId]);

    debugPrint("fetchById Done");

    return OrgClientModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgClientModel>>
    // return data.map((data) => OrgClientModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required OrgClientModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "client_id": model.clientId,
        "client_type_id": model.clientTypeId,
        "name": model.name,
        "business_legal_name": model.businessLegalName,
        "business_abn": model.businessAbn,
        "is_simple_client": model.isSimpleClient,
        "status": model.status,
        "email": model.email,
        "created_date": model.createdDate,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "is_synced": model.isSynced,
      },
      where: "client_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.clientId],
    );
  }

  Future<int> deleteRecord({required OrgClientModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database
        .delete(tableName, where: "client_id = ?", whereArgs: [model.clientId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_equipment_manufacturer_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgEquipmentManufacturer {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_equipment_manufacturer';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "equipment_manufacturer_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "phone_mobile" TEXT DEFAULT NULL,
      "phone_office_1" TEXT DEFAULT NULL,
      "phone_office_2" TEXT DEFAULT NULL,
      "email" TEXT NOT NULL,
      "address" TEXT DEFAULT NULL,
      "state" TEXT DEFAULT NULL,
      "country" TEXT NOT NULL,
      "status" INTEGER NOT NULL DEFAULT 1,
      "comment" TEXT DEFAULT NULL,
      "deleted" INTEGER NOT NULL DEFAULT 0,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("equipment_manufacturer_id" AUTOINCREMENT)
    );""");
  }

  Future<void> createRecordsBatch(
      {required List<OrgEquipmentManufacturerModel> models}) async {
    final database = await DatabaseService().database;
    List<OrgEquipmentManufacturerModel> insertList = [];
    List<OrgEquipmentManufacturerModel> updateList = [];
    // Fetch all IDs from the database
    final existingData = await database
        .rawQuery("""SELECT equipment_manufacturer_id FROM $tableName""");
    final Set<int> existingIds = existingData
        .map((rec) => rec['equipment_manufacturer_id'] as int)
        .toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.equipmentManufacturerId)) {
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
            "equipment_manufacturer_id": model.equipmentManufacturerId,
            "name": model.name,
            "phone_mobile": model.phoneMobile,
            "phone_office_1": model.phoneOfficeOne,
            "phone_office_2": model.phoneOfficeTwo,
            "email": model.email,
            "address": model.address,
            "state": model.state,
            "country": model.country,
            "status": model.status,
            "comment": model.comment,
            "deleted": model.deleted,
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
              "equipment_manufacturer_id": model.equipmentManufacturerId,
              "name": model.name,
              "phone_mobile": model.phoneMobile,
              "phone_office_1": model.phoneOfficeOne,
              "phone_office_2": model.phoneOfficeTwo,
              "email": model.email,
              "address": model.address,
              "state": model.state,
              "country": model.country,
              "status": model.status,
              "comment": model.comment,
              "deleted": model.deleted,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_by_signature": model.createdBySignature,
              "signature": model.signature,
              "is_synced": model.isSynced,
            },
            where: "equipment_manufacturer_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.equipmentManufacturerId],
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

  Future<int> createRecord(
      {required OrgEquipmentManufacturerModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "equipment_manufacturer_id": model.equipmentManufacturerId,
      "name": model.name,
      "phone_mobile": model.phoneMobile,
      "phone_office_1": model.phoneOfficeOne,
      "phone_office_2": model.phoneOfficeTwo,
      "email": model.email,
      "address": model.address,
      "state": model.state,
      "country": model.country,
      "status": model.status,
      "comment": model.comment,
      "deleted": model.deleted,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "is_synced": model.isSynced,
    });
  }

  Future<List<OrgEquipmentManufacturerModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(equipment_manufacturer_id, name, phone_mobile, phone_office_1, phone_office_2, email, address, state, country, status, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgEquipmentManufacturerModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgEquipmentManufacturerModel> fetchById(
      {required int equipmentManufacturerId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE equipment_manufacturer_id = ?""",
        [equipmentManufacturerId]);

    debugPrint("fetchById Done");

    return OrgEquipmentManufacturerModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgEquipmentManufacturerModel>>
    // return data.map((data) => OrgEquipmentManufacturerModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required OrgEquipmentManufacturerModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "equipment_manufacturer_id": model.equipmentManufacturerId,
        "name": model.name,
        "phone_mobile": model.phoneMobile,
        "phone_office_1": model.phoneOfficeOne,
        "phone_office_2": model.phoneOfficeTwo,
        "email": model.email,
        "address": model.address,
        "state": model.state,
        "country": model.country,
        "status": model.status,
        "comment": model.comment,
        "deleted": model.deleted,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "is_synced": model.isSynced,
      },
      where: "equipment_manufacturer_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.equipmentManufacturerId],
    );
  }

  Future<int> deleteRecord(
      {required OrgEquipmentManufacturerModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "equipment_manufacturer_id = ?",
        whereArgs: [model.equipmentManufacturerId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

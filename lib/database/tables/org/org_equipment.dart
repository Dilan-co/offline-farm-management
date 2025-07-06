import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class OrgEquipment {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'ORG_equipment';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "equipment_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "equipment_type_id" INTEGER NOT NULL,
      "equipment_manufacturer_id" INTEGER NOT NULL,
      "model" TEXT DEFAULT NULL,
      "serial_number" TEXT DEFAULT NULL,
      "name" TEXT NOT NULL,
      "label" TEXT NOT NULL,
      "description" TEXT DEFAULT NULL,
      "manufacture_year" TEXT DEFAULT NULL,
      "date_of_purchase" TEXT DEFAULT NULL,
      "person_responsible" TEXT DEFAULT NULL,
      "media" TEXT DEFAULT NULL,
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
      "read_only" INTEGER NOT NULL DEFAULT 0, -- Read Only. YES 1, NO 0,
      PRIMARY KEY("equipment_id" AUTOINCREMENT),
      FOREIGN KEY (equipment_type_id) REFERENCES ORG_equipment_type (equipment_type_id) ON UPDATE CASCADE,
      FOREIGN KEY (equipment_manufacturer_id) REFERENCES ORG_equipment_manufacturer (equipment_manufacturer_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE
    );""");
  }

  Future<void> createRecordsBatch(
      {required List<OrgEquipmentModel> models}) async {
    final database = await DatabaseService().database;

    // Step 1: Delete all records
    await deleteAllRecords();

    await database.transaction((txn) async {
      final batch = txn.batch();

      // Step 2: Insert records
      for (var model in models) {
        batch.insert(tableName, {
          "equipment_id": model.equipmentId,
          "client": model.client,
          "equipment_type_id": model.equipmentTypeId,
          "equipment_manufacturer_id": model.equipmentManufacturerId,
          "model": model.model,
          "serial_number": model.serialNumber,
          "name": model.name,
          "label": model.label,
          "description": model.description,
          "manufacture_year": model.manufactureYear,
          "date_of_purchase": model.dateOfPurchase,
          "person_responsible": model.personResponsible,
          "media": model.media,
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
          "read_only": model.readOnly,
        });
      }
      // Use `noResult: true` if results for each operation not needed
      final results = await batch.commit(noResult: false);

      // Results will contain row IDs of inserted records
      debugPrint("Batch insert completed. Results: $results");
      debugPrint("Batch insert completed for ${results.length} records.");
    });
  }

  Future<int> createRecord({required OrgEquipmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "equipment_id": model.equipmentId,
      "client": model.client,
      "equipment_type_id": model.equipmentTypeId,
      "equipment_manufacturer_id": model.equipmentManufacturerId,
      "model": model.model,
      "serial_number": model.serialNumber,
      "name": model.name,
      "label": model.label,
      "description": model.description,
      "manufacture_year": model.manufactureYear,
      "date_of_purchase": model.dateOfPurchase,
      "person_responsible": model.personResponsible,
      "media": model.media,
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
      "read_only": model.readOnly,
    });
  }

  Future<List<OrgEquipmentModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => OrgEquipmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<OrgEquipmentModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(equipment_id, client, equipment_type_id, equipment_manufacturer_id, model, serial_number, name, label, description, manufacture_year, date_of_purchase, person_responsible, media, status, comment, deleted, created_at, updated_at, created_by, updated_by, created_by_signature, signature, is_synced, read_only);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => OrgEquipmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<OrgEquipmentModel>> fetchAllReadOnlyOrNotRecords(
      {required bool isReadOnlyRecords}) async {
    final database = await DatabaseService().database;
    final isReadOnly = isReadOnlyRecords ? 1 : 0;

    final data = await database.rawQuery(
      "SELECT * FROM $tableName WHERE read_only = ?;",
      [isReadOnly],
    );

    debugPrint("fetchAllReadOnlyOrNotRecords Done");

    return data
        .map((data) => OrgEquipmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<OrgEquipmentModel> fetchById({required int equipmentId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE equipment_id = ?""", [equipmentId]);

    debugPrint("fetchById Done");

    return OrgEquipmentModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgEquipmentModel>>
    // return data.map((data) => OrgEquipmentModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required OrgEquipmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "equipment_id": model.equipmentId,
        "client": model.client,
        "equipment_type_id": model.equipmentTypeId,
        "equipment_manufacturer_id": model.equipmentManufacturerId,
        "model": model.model,
        "serial_number": model.serialNumber,
        "name": model.name,
        "label": model.label,
        "description": model.description,
        "manufacture_year": model.manufactureYear,
        "date_of_purchase": model.dateOfPurchase,
        "person_responsible": model.personResponsible,
        "media": model.media,
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
        "read_only": model.readOnly,
      },
      where: "equipment_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.equipmentId],
    );
  }

  Future<int> deleteRecord({required OrgEquipmentModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "equipment_id = ?", whereArgs: [model.equipmentId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }

  Future<void> deleteAllRecords() async {
    final database = await DatabaseService().database;

    await database.delete(tableName);

    debugPrint("Deleted all records from $tableName");
  }

  // Future<int> deleteExpiredRecords() async {
  //   final database = await DatabaseService().database;
  //   // Current date in YYYY-MM-DD format
  //   String today = DateTime.now().toString().split(' ')[0];
  //   // Raw SQL query to delete expired records
  //   int result = await database.rawDelete(
  //     """DELETE FROM $tableName WHERE date(delete_date) < date(?)""",
  //     [today],
  //   );
  //   debugPrint("deleteExpiredRecords Done --> $result");
  //   return result;
  // }
}

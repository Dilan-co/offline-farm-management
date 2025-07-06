import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class PackagingTareWeightCheck {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_packaging_tare_weight_check';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "packaging_tare_weight_check_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "packaging_format" TEXT NOT NULL,
      "gross_weight_of_finished_product" TEXT NOT NULL,
      "weight_of_outer_packaging" TEXT DEFAULT NULL,
      "weight_of_liner" TEXT DEFAULT NULL,
      "weight_of_primary_packaging" TEXT DEFAULT NULL,
      "total_weight_of_packaging" TEXT NOT NULL,
      "nett_weight_of_product" TEXT NOT NULL,
      "weight_claimed_on_label_or_packaging" TEXT DEFAULT NULL,
      "check_weight_again" INTEGER NOT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("packaging_tare_weight_check_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required PackagingTareWeightCheckModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "packaging_tare_weight_check_id": model.packagingTareWeightCheckId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "packaging_format": model.packagingFormat,
      "gross_weight_of_finished_product": model.grossWeightOfFinishedProduct,
      "weight_of_outer_packaging": model.weightOfOuterPackaging,
      "weight_of_liner": model.weightOfLiner,
      "weight_of_primary_packaging": model.weightOfPrimaryPackaging,
      "total_weight_of_packaging": model.totalWeightOfPackaging,
      "nett_weight_of_product": model.netWeightOfProduct,
      "weight_claimed_on_label_or_packaging":
          model.weightClaimedOnLabelOrPackaging,
      "check_weight_again": model.checkWeightAgain,
      "comment": model.comment,
      "user_id": model.userId,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "signature": model.signature,
      "is_synced": model.isSynced,
      "delete_date": model.deleteDate,
    });
  }

  Future<List<PackagingTareWeightCheckModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => PackagingTareWeightCheckModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<PackagingTareWeightCheckModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(packaging_tare_weight_check_id, client, farm, crop, packaging_format, gross_weight_of_finished_product, weight_of_outer_packaging, weight_of_liner, weight_of_primary_packaging, total_weight_of_packaging, nett_weight_of_product, weight_claimed_on_label_or_packaging, check_weight_again, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => PackagingTareWeightCheckModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<PackagingTareWeightCheckModel> fetchById(
      {required int packagingTareWeightCheckId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE packaging_tare_weight_check_id = ?""",
        [packagingTareWeightCheckId]);

    debugPrint("fetchById Done");

    return PackagingTareWeightCheckModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<PackagingTareWeightCheckModel>>
    // return data.map((data) => PackagingTareWeightCheckModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required PackagingTareWeightCheckModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "packaging_tare_weight_check_id": model.packagingTareWeightCheckId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "packaging_format": model.packagingFormat,
        "gross_weight_of_finished_product": model.grossWeightOfFinishedProduct,
        "weight_of_outer_packaging": model.weightOfOuterPackaging,
        "weight_of_liner": model.weightOfLiner,
        "weight_of_primary_packaging": model.weightOfPrimaryPackaging,
        "total_weight_of_packaging": model.totalWeightOfPackaging,
        "nett_weight_of_product": model.netWeightOfProduct,
        "weight_claimed_on_label_or_packaging":
            model.weightClaimedOnLabelOrPackaging,
        "check_weight_again": model.checkWeightAgain,
        "comment": model.comment,
        "user_id": model.userId,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "signature": model.signature,
        "is_synced": model.isSynced,
        "delete_date": model.deleteDate,
      },
      where: "packaging_tare_weight_check_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.packagingTareWeightCheckId],
    );
  }

  Future<int> deleteRecord(
      {required PackagingTareWeightCheckModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "packaging_tare_weight_check_id = ?",
        whereArgs: [model.packagingTareWeightCheckId]);

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

import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class FinishedProductWeightCheckHourly {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_finished_product_weight_check_hourly';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "finished_product_weight_check_hourly_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "hourly_weight_check" TEXT DEFAULT NULL,
      "net_weight" TEXT DEFAULT NULL,
      "corrective_action" TEXT DEFAULT NULL,
      "packaging_tare_weight" TEXT DEFAULT NULL,
      "minimum_gross_weight" TEXT DEFAULT NULL,
      "packing_line" TEXT DEFAULT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER NOT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("finished_product_weight_check_hourly_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required FinishedProductWeightCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "finished_product_weight_check_hourly_id":
          model.finishedProductWeightCheckHourlyId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "date": model.date,
      "hourly_weight_check": model.hourlyWeightCheck,
      "net_weight": model.netWeight,
      "corrective_action": model.correctiveAction,
      "packaging_tare_weight": model.packagingTareWeight,
      "minimum_gross_weight": model.minimumGrossWeight,
      "packing_line": model.packingLine,
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

  Future<List<FinishedProductWeightCheckHourlyModel>>
      fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) =>
            FinishedProductWeightCheckHourlyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<FinishedProductWeightCheckHourlyModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(finished_product_weight_check_hourly_id, client, farm, crop, date, hourly_weight_check, net_weight, corrective_action, packaging_tare_weight, minimum_gross_weight, packing_line, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) =>
            FinishedProductWeightCheckHourlyModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<FinishedProductWeightCheckHourlyModel> fetchById(
      {required int finishedProductWeightCheckHourlyId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE finished_product_weight_check_hourly_id = ?""",
        [finishedProductWeightCheckHourlyId]);

    debugPrint("fetchById Done");

    return FinishedProductWeightCheckHourlyModel.fromSqfliteDatabase(
        data.first);

    //To get a list of data <List<FinishedProductWeightCheckHourlyModel>>
    // return data.map((data) => FinishedProductWeightCheckHourlyModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required FinishedProductWeightCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "finished_product_weight_check_hourly_id":
            model.finishedProductWeightCheckHourlyId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "date": model.date,
        "hourly_weight_check": model.hourlyWeightCheck,
        "net_weight": model.netWeight,
        "corrective_action": model.correctiveAction,
        "packaging_tare_weight": model.packagingTareWeight,
        "minimum_gross_weight": model.minimumGrossWeight,
        "packing_line": model.packingLine,
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
      where: "finished_product_weight_check_hourly_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.finishedProductWeightCheckHourlyId],
    );
  }

  Future<int> deleteRecord(
      {required FinishedProductWeightCheckHourlyModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "finished_product_weight_check_hourly_id = ?",
        whereArgs: [model.finishedProductWeightCheckHourlyId]);

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

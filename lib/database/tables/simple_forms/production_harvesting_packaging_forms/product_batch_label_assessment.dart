import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ProductionBatchLabelAssessment {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_production_batch_label_assessment';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "production_batch_label_assessment_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "production_batch_number" TEXT NOT NULL,
      "variety" TEXT DEFAULT NULL,
      "pack_date" TEXT NOT NULL,
      "start_time" TEXT DEFAULT NULL,
      "end_time" TEXT DEFAULT NULL,
      "label_sample_01" TEXT DEFAULT NULL,
      "pack_date_01" TEXT DEFAULT NULL,
      "best_before_date_01" TEXT DEFAULT NULL,
      "label_position_01" INTEGER DEFAULT NULL,
      "label_legible_01" INTEGER DEFAULT NULL,
      "label_sample_02" TEXT DEFAULT NULL,
      "pack_date_02" TEXT DEFAULT NULL,
      "best_before_date_02" TEXT DEFAULT NULL,
      "label_position_02" INTEGER DEFAULT NULL,
      "label_legible_02" INTEGER DEFAULT NULL,
      "corrective_action" TEXT DEFAULT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("production_batch_label_assessment_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord(
      {required ProductionBatchLabelAssessmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "production_batch_label_assessment_id":
          model.productionBatchLabelAssessmentId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "production_batch_number": model.productionBatchNumber,
      "variety": model.variety,
      "pack_date": model.packDate,
      "start_time": model.startTime,
      "end_time": model.endTime,
      "label_sample_01": model.labelSampleOne,
      "pack_date_01": model.packDateOne,
      "best_before_date_01": model.bestBeforeDateOne,
      "label_position_01": model.labelPositionOne,
      "label_legible_01": model.labelLegibleOne,
      "label_sample_02": model.labelSampleTwo,
      "pack_date_02": model.packDateTwo,
      "best_before_date_02": model.bestBeforeDateTwo,
      "label_position_02": model.labelPositionTwo,
      "label_legible_02": model.labelLegibleTwo,
      "corrective_action": model.correctiveAction,
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

  Future<List<ProductionBatchLabelAssessmentModel>>
      fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) =>
            ProductionBatchLabelAssessmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<ProductionBatchLabelAssessmentModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(production_batch_label_assessment_id, client, farm, crop, production_batch_number, variety, pack_date, start_time, end_time, label_sample_01, pack_date_01, best_before_date_01, label_position_01, label_legible_01, label_sample_02, pack_date_02, best_before_date_02, label_position_02, label_legible_02, corrective_action, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) =>
            ProductionBatchLabelAssessmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<ProductionBatchLabelAssessmentModel> fetchById(
      {required int productionBatchLabelAssessmentId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE production_batch_label_assessment_id = ?""",
        [productionBatchLabelAssessmentId]);

    debugPrint("fetchById Done");

    return ProductionBatchLabelAssessmentModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<ProductionBatchLabelAssessmentModel>>
    // return data.map((data) => ProductionBatchLabelAssessmentModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord(
      {required ProductionBatchLabelAssessmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "production_batch_label_assessment_id":
            model.productionBatchLabelAssessmentId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "production_batch_number": model.productionBatchNumber,
        "variety": model.variety,
        "pack_date": model.packDate,
        "start_time": model.startTime,
        "end_time": model.endTime,
        "label_sample_01": model.labelSampleOne,
        "pack_date_01": model.packDateOne,
        "best_before_date_01": model.bestBeforeDateOne,
        "label_position_01": model.labelPositionOne,
        "label_legible_01": model.labelLegibleOne,
        "label_sample_02": model.labelSampleTwo,
        "pack_date_02": model.packDateTwo,
        "best_before_date_02": model.bestBeforeDateTwo,
        "label_position_02": model.labelPositionTwo,
        "label_legible_02": model.labelLegibleTwo,
        "corrective_action": model.correctiveAction,
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
      where: "production_batch_label_assessment_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.productionBatchLabelAssessmentId],
    );
  }

  Future<int> deleteRecord(
      {required ProductionBatchLabelAssessmentModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "production_batch_label_assessment_id = ?",
        whereArgs: [model.productionBatchLabelAssessmentId]);

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

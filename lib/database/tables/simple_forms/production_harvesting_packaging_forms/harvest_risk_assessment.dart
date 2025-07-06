import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class HarvestRiskAssessment {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_harvest_risk_assessment_whp_observation';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "harvest_risk_assessment_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "block_range" TEXT DEFAULT NULL,
      "harvest_date" TEXT NOT NULL,
      "last_spay_date_time" TEXT DEFAULT NULL,
      "withhold_period_applied" TEXT DEFAULT NULL,
      "safe_date_to_harvest" TEXT DEFAULT NULL,
      "harvest_authorised_by" TEXT DEFAULT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER NOT NULL,
      "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER NOT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "sprayed_with" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("harvest_risk_assessment_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord({required HarvestRiskAssessmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "harvest_risk_assessment_id": model.harvestRiskAssessmentId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "block_range": model.blockRange,
      "harvest_date": model.harvestDate,
      "last_spay_date_time": model.lastSprayDateTime,
      "withhold_period_applied": model.withholdPeriodApplied,
      "safe_date_to_harvest": model.safeDateToHarvest,
      "harvest_authorised_by": model.harvestAuthorizedBy,
      "comment": model.comment,
      "user_id": model.userId,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "signature": model.signature,
      "sprayed_with": model.sprayedWith,
      "is_synced": model.isSynced,
      "delete_date": model.deleteDate,
    });
  }

  Future<List<HarvestRiskAssessmentModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => HarvestRiskAssessmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<HarvestRiskAssessmentModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(harvest_risk_assessment_id, client, farm, crop, block_range, harvest_date, last_spay_date_time, withhold_period_applied, safe_date_to_harvest, harvest_authorised_by, comment, user_id, created_at, updated_at, created_by, updated_by, signature, sprayed_with, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => HarvestRiskAssessmentModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<HarvestRiskAssessmentModel> fetchById(
      {required int harvestRiskAssessmentId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE harvest_risk_assessment_id = ?""",
        [harvestRiskAssessmentId]);

    debugPrint("fetchById Done");

    return HarvestRiskAssessmentModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<HarvestRiskAssessmentModel>>
    // return data.map((data) => HarvestRiskAssessmentModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required HarvestRiskAssessmentModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "harvest_risk_assessment_id": model.harvestRiskAssessmentId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "block_range": model.blockRange,
        "harvest_date": model.harvestDate,
        "last_spay_date_time": model.lastSprayDateTime,
        "withhold_period_applied": model.withholdPeriodApplied,
        "safe_date_to_harvest": model.safeDateToHarvest,
        "harvest_authorised_by": model.harvestAuthorizedBy,
        "comment": model.comment,
        "user_id": model.userId,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "signature": model.signature,
        "sprayed_with": model.sprayedWith,
        "is_synced": model.isSynced,
        "delete_date": model.deleteDate,
      },
      where: "harvest_risk_assessment_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.harvestRiskAssessmentId],
    );
  }

  Future<int> deleteRecord({required HarvestRiskAssessmentModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "harvest_risk_assessment_id = ?",
        whereArgs: [model.harvestRiskAssessmentId]);

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

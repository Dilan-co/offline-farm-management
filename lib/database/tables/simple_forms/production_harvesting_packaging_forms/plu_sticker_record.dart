import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/plu_sticker_record_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class PluStickerRecord {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'SIMPLE_FORM_plu_sticker';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "plu_sticker_id" INTEGER NOT NULL,
      "client" INTEGER NOT NULL,
      "farm" INTEGER NOT NULL,
      "crop" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "time" TEXT DEFAULT NULL,
      "cassette_number" TEXT DEFAULT NULL,
      "line_clearance" INTEGER NOT NULL DEFAULT 1,
      "plu_new" TEXT DEFAULT NULL,
      "plu_old" TEXT DEFAULT NULL,
      "comment" TEXT DEFAULT NULL,
      "user_id" INTEGER DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL,
      "updated_by" INTEGER DEFAULT NULL,
      "signature" TEXT NOT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      "delete_date" TEXT DEFAULT NULL,
      PRIMARY KEY("plu_sticker_id" AUTOINCREMENT),
      FOREIGN KEY (user_id) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (farm) REFERENCES ORG_client_farm (client_farm_id) ON UPDATE CASCADE,
      FOREIGN KEY (crop) REFERENCES CROP_crop (crop_id) ON UPDATE CASCADE,
      FOREIGN KEY (client) REFERENCES ORG_client (client_id) ON UPDATE CASCADE,
      FOREIGN KEY (created_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE,
      FOREIGN KEY (updated_by) REFERENCES USER_user (user_id) ON UPDATE CASCADE
    );""");
  }

  Future<int> createRecord({required PluStickerRecordModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "plu_sticker_id": model.pluStickerId,
      "client": model.client,
      "farm": model.farm,
      "crop": model.crop,
      "date": model.date,
      "time": model.time,
      "cassette_number": model.cassetteNumber,
      "line_clearance": model.lineClearance,
      "plu_new": model.pluNew,
      "plu_old": model.pluOld,
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

  Future<List<PluStickerRecordModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data
        .map((data) => PluStickerRecordModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<List<PluStickerRecordModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(plu_sticker_id, client, farm, crop, date, time, cassette_number, line_clearance, plu_new, plu_old, comment, user_id, created_at, updated_at, created_by, updated_by, signature, is_synced, delete_date);""");

    debugPrint("fetchAllRecords Done");

    return data
        .map((data) => PluStickerRecordModel.fromSqfliteDatabase(data))
        .toList();
  }

  Future<PluStickerRecordModel> fetchById({required int pluStickerId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE plu_sticker_id = ?""",
        [pluStickerId]);

    debugPrint("fetchById Done");

    return PluStickerRecordModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<PluStickerRecordModel>>
    // return data.map((data) => PluStickerRecordModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required PluStickerRecordModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "plu_sticker_id": model.pluStickerId,
        "client": model.client,
        "farm": model.farm,
        "crop": model.crop,
        "date": model.date,
        "time": model.time,
        "cassette_number": model.cassetteNumber,
        "line_clearance": model.lineClearance,
        "plu_new": model.pluNew,
        "plu_old": model.pluOld,
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
      where: "plu_sticker_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.pluStickerId],
    );
  }

  Future<int> deleteRecord({required PluStickerRecordModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database.delete(tableName,
        where: "plu_sticker_id = ?", whereArgs: [model.pluStickerId]);

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

import 'package:flutter/material.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class User {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'USER_user';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "user_id" INTEGER NOT NULL,
      "username" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      "pin_code" TEXT DEFAULT NULL,
      "displayname" TEXT NOT NULL,
      "first_name" TEXT NOT NULL,
      "last_name" TEXT NOT NULL,
      "user_type" TEXT NOT NULL,
      "title" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "telephone" TEXT DEFAULT NULL,
      "mobile" TEXT NOT NULL,
      "fax" TEXT DEFAULT NULL,
      "created_at" TEXT DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "created_by" INTEGER DEFAULT NULL, 
      "updated_by" INTEGER DEFAULT NULL,
      "created_by_signature" TEXT DEFAULT NULL,
      "signature" TEXT DEFAULT NULL,
      "deleted" INTEGER NOT NULL DEFAULT 0,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0,
      PRIMARY KEY("user_id" AUTOINCREMENT)
    );""");
    int index = await addRecords();

    debugPrint("USER_user addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;

    try {
      // Generate the SQL query dynamically
      String query =
          """INSERT INTO $tableName (user_id, username, password, pin_code, displayname, first_name, last_name, user_type, title, email, telephone, mobile, fax, created_at, updated_at, created_by, updated_by, created_by_signature, signature, deleted) VALUES 
        (3, 'admin', 'nw2aru03WHp4kOxWCkAGMe', '1234', 'Administrator', 'Super', 'Admin', 'superAdmin', 'Mr', 'admin@mailinator.com', '07701234567', '07701234567', '', NULL, '2025-01-22 05:27:53', NULL, 3, NULL, NULL, 0),
        (4, 'svisor', 'nw2aru03WHp4', '1234', 'Turf Supervisor', 'Super', 'Visor', 'supervisor', 'Mr', 'supervisor@mailinator.com', '07701234567', '07701234567', '', NULL, '2025-01-22 05:27:53', NULL, 3, 3, NULL, 0),
        (5, 'dilan', 'yU9e00ZVMgVH2CHuiKqDeuAHbRH', '1234', 'Dilan Gunawardhana', 'Dilan', 'Gunawardhana', 'qaOfficer', 'Mr', 'd.m.gunawardhana@gmail.com', '07701234567', '07701234567', '', '2025-01-22 23:25:06', '2025-01-22 04:18:06', 3, 3, NULL, NULL, 0),
        (6, 'worker1', '3cIoLD9l0p71', '1234', 'Bron Pressler', 'Bron', 'Pressler', 'worker', 'Mr', 'd.m.gunawardhana@gmail.com', '07701234567', '07701234567', '', '2025-01-22 20:13:50', '2025-01-22 20:20:39', 3, 3, NULL, NULL, 0),
        (7, 'worker2', '6ibhIoL9l0p71s2d2', '1234', 'Rayan Niel', 'Rayan', 'Niel', 'worker', 'Mr', 'd.m.gunawardhana@gmail.com', '07701234567', '07701234567', '', '2025-01-22 20:13:50', '2025-01-22 20:20:39', 3, 3, NULL, NULL, 0);""";

      debugPrint("USER_user addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint('Error adding data to USER_user: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch({required List<UserModel> models}) async {
    final database = await DatabaseService().database;

    List<UserModel> insertList = [];
    List<UserModel> updateList = [];
    // Fetch all IDs from the database
    final existingData =
        await database.rawQuery("""SELECT user_id FROM $tableName""");
    final Set<int> existingIds =
        existingData.map((rec) => rec['user_id'] as int).toSet();
    // Step 1: Check all records if they are already exist in the table
    for (var record in models) {
      if (existingIds.contains(record.userId)) {
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
            "user_id": model.userId,
            "username": model.username,
            "password": model.password,
            "pin_code": model.pinCode,
            "displayname": model.displayName,
            "first_name": model.firstName,
            "last_name": model.lastName,
            "user_type": model.userType,
            "title": model.title,
            "email": model.email,
            "telephone": model.telephone,
            "mobile": model.mobile,
            "fax": model.fax,
            "created_at": model.createdAt,
            "updated_at": model.updatedAt,
            "created_by": model.createdBy,
            "updated_by": model.updatedBy,
            "created_by_signature": model.createdBySignature,
            "signature": model.signature,
            "deleted": model.deleted,
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
              "user_id": model.userId,
              "username": model.username,
              "password": model.password,
              "pin_code": model.pinCode,
              "displayname": model.displayName,
              "first_name": model.firstName,
              "last_name": model.lastName,
              "user_type": model.userType,
              "title": model.title,
              "email": model.email,
              "telephone": model.telephone,
              "mobile": model.mobile,
              "fax": model.fax,
              "created_at": model.createdAt,
              "updated_at": model.updatedAt,
              "created_by": model.createdBy,
              "updated_by": model.updatedBy,
              "created_by_signature": model.createdBySignature,
              "signature": model.signature,
              "deleted": model.deleted,
              "is_synced": model.isSynced,
            },
            where: "user_id = ?",
            conflictAlgorithm: ConflictAlgorithm.rollback,
            whereArgs: [model.userId],
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

  Future<int> createRecord({required UserModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "user_id": model.userId,
      "username": model.username,
      "password": model.password,
      "pin_code": model.pinCode,
      "displayname": model.displayName,
      "first_name": model.firstName,
      "last_name": model.lastName,
      "user_type": model.userType,
      "title": model.title,
      "email": model.email,
      "telephone": model.telephone,
      "mobile": model.mobile,
      "fax": model.fax,
      "created_at": model.createdAt,
      "updated_at": model.updatedAt,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_by_signature": model.createdBySignature,
      "signature": model.signature,
      "deleted": model.deleted,
      "is_synced": model.isSynced,
    });
  }

  Future<List<UserModel>> fetchAllRecords() async {
    final database = await DatabaseService().database;

    final data = await database.rawQuery(
        """SELECT * from $tableName ORDER BY COALESCE(user_id, username, password, pin_code, displayname, first_name, last_name, user_type, title, email, telephone, mobile, fax, created_at, updated_at, created_by, updated_by, created_by_signature, signature, deleted, is_synced);""");

    debugPrint("fetchAllRecords Done");

    return data.map((data) => UserModel.fromSqfliteDatabase(data)).toList();
  }

  Future<UserModel?> fetchById({required int userId}) async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE user_id = ?""", [userId]);

    debugPrint("fetchById Done");
    // Return null if no record is found
    if (data.isEmpty) {
      return null;
    }

    return UserModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<UserModel>>
    // return data.map((data) => UserModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<UserModel?> fetchByUsername({required String userName}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE username = ?""", [userName]);

    debugPrint("fetchByUsername Done");

    if (data.isNotEmpty) {
      return UserModel.fromJson(data.first);
    } else {
      return null;
    }

    //To get a list of data <List<UserModel>>
    // return data.map((data) => UserModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required UserModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "user_id": model.userId,
        "username": model.username,
        "password": model.password,
        "pin_code": model.pinCode,
        "displayname": model.displayName,
        "first_name": model.firstName,
        "last_name": model.lastName,
        "user_type": model.userType,
        "title": model.title,
        "email": model.email,
        "telephone": model.telephone,
        "mobile": model.mobile,
        "fax": model.fax,
        "created_at": model.createdAt,
        "updated_at": model.updatedAt,
        "created_by": model.createdBy,
        "updated_by": model.updatedBy,
        "created_by_signature": model.createdBySignature,
        "signature": model.signature,
        "deleted": model.deleted,
        "is_synced": model.isSynced,
      },
      where: "user_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.userId],
    );
  }

  Future<int> deleteRecord({required UserModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database
        .delete(tableName, where: "user_id = ?", whereArgs: [model.userId]);

    debugPrint("deleteRecord Done");
    return recordId;
  }
}

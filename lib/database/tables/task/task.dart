import 'package:farm_management/services/multipart_form_request.dart';
import 'package:flutter/material.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';

class Task {
  //Change table name according to form name. Create separate files for each form including table models.
  final tableName = 'TASK_task';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "task_id" INTEGER NOT NULL,
      "area" TEXT NOT NULL,
      "section" TEXT NOT NULL,
      "user_id" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "description" TEXT DEFAULT NULL,
      "is_completed" INTEGER NOT NULL DEFAULT 0,
      "created_by" INTEGER DEFAULT NULL,
      "updated_at" TEXT DEFAULT NULL,
      "is_synced" INTEGER NOT NULL DEFAULT 1, -- Synced to backend. YES 1, NO 0
      PRIMARY KEY("task_id" AUTOINCREMENT)
    );""");
    int index = await addRecords();

    debugPrint("TASK_task addRecords Done --> $index");
  }

  Future<int> addRecords() async {
    final database = await DatabaseService().database;

    try {
      // Generate the SQL query dynamically
      String query =
          """INSERT INTO $tableName (task_id, area, section, user_id, date, description, is_completed, created_by, updated_at, is_synced) VALUES 
        (1, 'Area 01', 'Section 01', 6, '2025-07-06 08:15:00', 'Weed the crops manually and ensure the pathways between beds are clear.', 1, 4, '2025-07-05 08:20:00', 0),
        (2, 'Area 05', 'Section 02', 6, '2025-07-06 10:45:00', 'Inspect the irrigation valves and clear any blockages in the main lines.', 0, 4, '2025-07-05 10:50:00', 1),
        (3, 'Area 02', 'Section 03', 7, '2025-07-06 10:45:00', 'Ensure sprinkler heads are functioning and positioned correctly.', 0, 4, '2025-07-05 10:50:00', 1),
        (4, 'Area 02', 'Section 04', 6, '2025-07-06 10:45:00', 'Flush the irrigation lines and test water pressure across all sections.', 0, 4, '2025-07-05 10:50:00', 1),
        (5, 'Area 02', 'Section 03', 6, '2025-07-05 09:00:00', 'Inspect plants for pest damage and apply organic treatment if needed.', 1, 4, '2025-07-04 09:05:00', 1),
        (6, 'Area 01', 'Section 07', 7, '2025-07-05 13:30:00', 'Harvest mature vegetables and sort them into clean baskets.', 1, 4, '2025-07-03 13:35:00', 1),
        (7, 'Area 05', 'Section 09', 7, '2025-07-04 07:50:00', 'Prepare the soil for planting by removing rocks and leveling the surface.', 1, 4, '2025-07-03 08:00:00', 1),
        (8, 'Area 05', 'Section 11', 6, '2025-07-07 08:00:00', 'Plant seedlings in straight rows and water them immediately after.', 0, 4, '2025-07-05 08:05:00', 1),
        (9, 'Area 02', 'Section 02', 7, '2025-07-08 14:10:00', 'Apply compost evenly across all beds in preparation for planting.', 0, 4, '2025-07-06 14:15:00', 0),
        (10, 'Area 03', 'Section 04', 6, '2025-07-09 15:20:00', 'Label newly planted sections with tags showing date and crop type.', 0, 4, '2025-07-06 15:25:00', 0),
        (11, 'Area 04', 'Section 06', 7, '2025-07-03 11:40:00', 'Sweep and clean the storage area, then restock fertilizer bags.', 1, 4, '2025-07-02 11:45:00', 1),
        (12, 'Area 04', 'Section 08', 7, '2025-07-10 16:00:00', 'Collect and log temperature and humidity readings from sensors.', 0, 4, '2025-07-06 16:05:00', 0);""";

      debugPrint("USER_user addRecords Done");
      return await database.rawInsert(query);
    } catch (e) {
      debugPrint('Error adding data to USER_user: $e');
      return -1;
    }
  }

  Future<void> createRecordsBatch({required List<TaskModel> models}) async {
    final database = await DatabaseService().database;

    // Step 1: Delete all records
    await deleteAllRecords();

    await database.transaction((txn) async {
      final batch = txn.batch();

      // Step 2: Insert records
      for (var model in models) {
        batch.insert(tableName, {
          "task_id": model.taskId,
          "area": model.area,
          "section": model.section,
          "user_id": model.userId,
          "date": model.date,
          "description": model.description,
          "is_completed": model.isCompleted,
          "created_by": model.createdBy,
          "updated_at": model.updatedAt,
          "is_synced": model.isSynced,
        });
      }
      // Use `noResult: true` if results for each operation not needed
      final results = await batch.commit(noResult: false);

      // Results will contain row IDs of inserted records
      debugPrint("Batch insert completed. Results: $results");
      debugPrint("Batch insert completed for ${results.length} records.");
    });
  }

  Future<int> createRecord({required TaskModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("createRecord Done");

    return await database.insert(tableName, {
      "task_id": model.taskId,
      "area": model.area,
      "section": model.section,
      "user_id": model.userId,
      "date": model.date,
      "description": model.description,
      "is_completed": model.isCompleted,
      "created_by": model.createdBy,
      "updated_at": model.updatedAt,
      "is_synced": model.isSynced,
    });
  }

  Future<List<TaskModel>> fetchNotSyncedRecords() async {
    final database = await DatabaseService().database;
    final data = await database
        .rawQuery("""SELECT * from $tableName WHERE is_synced = 0""");

    debugPrint("fetchNotSyncedRecords Done");

    return data.map((data) => TaskModel.fromSqfliteDatabase(data)).toList();
  }

  // Future<List<TaskModel>> fetchAllRecords() async {
  //   final database = await DatabaseService().database;

  //   final data = await database.rawQuery(
  //       """SELECT * from $tableName ORDER BY COALESCE(task_id, area, section, user_id, date, description, is_completed, created_by, updated_at, is_synced);""");

  //   debugPrint("fetchAllRecords Done");

  //   return data.map((data) => TaskModel.fromSqfliteDatabase(data)).toList();
  // }

  Future<List<TaskModel>> fetchAllTodayRecords() async {
    final database = await DatabaseService().database;
    int loggedUserId = stateController.getLoggedUserId();

    // Get today's date as 'YYYY-MM-DD'
    String today = DateTime.now().toString().split(' ')[0];

    final data = await database.rawQuery(
      """SELECT * FROM $tableName 
       WHERE date(date) = date(?) 
       AND user_id = ? 
       ORDER BY date(date) ASC;""",
      [today, loggedUserId],
    );

    debugPrint("fetchAllTodayRecords Done");

    return data.map((row) => TaskModel.fromSqfliteDatabase(row)).toList();
  }

  Future<List<TaskModel>> fetchAllFutureRecords() async {
    final database = await DatabaseService().database;
    int loggedUserId = stateController.getLoggedUserId();

    // Get today's date as 'YYYY-MM-DD'
    String today = DateTime.now().toString().split(' ')[0];

    final data = await database.rawQuery(
      """SELECT * FROM $tableName 
       WHERE date(date) > date(?) 
       AND created_by = ? 
       ORDER BY date(date) ASC;""",
      [today, loggedUserId],
    );

    debugPrint("fetchAllFutureRecords Done");

    return data.map((row) => TaskModel.fromSqfliteDatabase(row)).toList();
  }

  Future<List<TaskModel>> fetchTodayOrOlderRecords() async {
    final database = await DatabaseService().database;
    int loggedUserId = stateController.getLoggedUserId();

    // Get today's date as 'YYYY-MM-DD'
    String today = DateTime.now().toString().split(' ')[0];

    final data = await database.rawQuery(
      """SELECT * FROM $tableName 
       WHERE date(date) <= date(?) 
       AND created_by = ? 
       ORDER BY date(date) DESC;""",
      [today, loggedUserId],
    );

    debugPrint("fetchTodayOrOlderRecords Done");

    return data.map((row) => TaskModel.fromSqfliteDatabase(row)).toList();
  }

  Future<TaskModel> fetchById({required int equipmentTypeId}) async {
    final database = await DatabaseService().database;
    final data = await database.rawQuery(
        """SELECT * from $tableName WHERE task_id = ?""", [equipmentTypeId]);

    debugPrint("fetchById Done");

    return TaskModel.fromSqfliteDatabase(data.first);

    //To get a list of data <List<OrgEquipmentTypeModel>>
    // return data.map((data) => OrgEquipmentTypeModel.fromSqfliteDatabase(data))
    //     .toList();
  }

  Future<int> updateRecord({required TaskModel model}) async {
    final database = await DatabaseService().database;

    debugPrint("updateRecord Done");

    return await database.update(
      tableName,
      {
        "task_id": model.taskId,
        "area": model.area,
        "section": model.section,
        "user_id": model.userId,
        "date": model.date,
        "description": model.description,
        "is_completed": model.isCompleted,
        "created_by": model.createdBy,
        "updated_at": model.updatedAt,
        "is_synced": model.isSynced,
      },
      where: "task_id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [model.taskId],
    );
  }

  Future<int> deleteRecord({required TaskModel model}) async {
    final database = await DatabaseService().database;

    int recordId = await database
        .delete(tableName, where: "task_id = ?", whereArgs: [model.taskId]);

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

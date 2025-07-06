class TaskModel {
  final int? taskId;
  final String area;
  final String section;
  final int userId;
  final String date;
  final String? description;
  int isCompleted;
  final int? createdBy;
  final String? updatedAt;
  int isSynced;

  TaskModel({
    required this.taskId,
    required this.area,
    required this.section,
    required this.userId,
    required this.date,
    required this.description,
    required this.isCompleted,
    required this.createdBy,
    required this.updatedAt,
    required this.isSynced,
  });

  factory TaskModel.fromSqfliteDatabase(Map<String, dynamic> map) => TaskModel(
        taskId: map['task_id'],
        area: map['area'],
        section: map['section'],
        userId: map['user_id'],
        date: map['date'],
        description: map['description'],
        isCompleted: map['is_completed'],
        createdBy: map['created_by'],
        updatedAt: map['updated_at'],
        isSynced: map['is_synced'],
      );

  factory TaskModel.fromJson(Map<String, dynamic> map) => TaskModel(
        taskId: map["task_id"] is String
            ? int.tryParse(map["task_id"] ?? "")
            : map["task_id"],
        area: map["area"] ?? "",
        section: map["section"] ?? "",
        userId: map["user_id"] is String
            ? int.tryParse(map["user_id"] ?? "0") ?? 0
            : map["user_id"] ?? 0,
        date: map["date"] ?? "",
        description: map["description"],
        isCompleted: map["is_completed"] is String
            ? int.tryParse(map["is_completed"] ?? "0") ?? 0
            : map["is_completed"] ?? 0,
        createdBy: map["created_by"],
        updatedAt: map["updated_at"],
        isSynced: 1,
      );

  Map<String, String?> toJson() {
    return {
      "area": area.toString(),
      "section": section.toString(),
      "user_id": userId.toString(),
      "date": date.toString(),
      "description": description?.toString(),
      "is_completed": isCompleted.toString(),
      "created_by": createdBy?.toString(),
      "updated_at": updatedAt?.toString(),
    };
  }
}

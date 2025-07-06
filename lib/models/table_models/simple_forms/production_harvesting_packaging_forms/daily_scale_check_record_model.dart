class DailyScaleCheckModel {
  final int? dailyScaleCheckId;
  final String date;
  final int client;
  final int farm;
  final int crop;
  final String? lineNumber;
  final String scaleName;
  final String fivePointCheck;
  final String testMassWeight;
  final String scaleReading;
  final String? comment;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  DailyScaleCheckModel({
    required this.dailyScaleCheckId,
    required this.date,
    required this.client,
    required this.farm,
    required this.crop,
    required this.lineNumber,
    required this.scaleName,
    required this.fivePointCheck,
    required this.testMassWeight,
    required this.scaleReading,
    required this.comment,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.signature,
    required this.isSynced,
    this.deleteDate,
  });

  factory DailyScaleCheckModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      DailyScaleCheckModel(
        dailyScaleCheckId: map["daily_scale_check_id"],
        date: map["date"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        lineNumber: map["line_number"],
        scaleName: map["scale_name"],
        fivePointCheck: map["five_point_check"],
        testMassWeight: map["test_mass_weight"],
        scaleReading: map["scale_reading"],
        comment: map["comment"],
        userId: map["user_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        signature: map["signature"],
        isSynced: map["is_synced"],
        deleteDate: map["delete_date"],
      );

  Map<String, String?> toJson() {
    return {
      "date": date.toString(),
      "client": client.toString(),
      "farm": farm.toString(),
      "crop": crop.toString(),
      "line_number": lineNumber?.toString(),
      "scale_name": scaleName.toString(),
      "five_point_check": fivePointCheck.toString(),
      "test_mass_weight": testMassWeight.toString(),
      "scale_reading": scaleReading.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

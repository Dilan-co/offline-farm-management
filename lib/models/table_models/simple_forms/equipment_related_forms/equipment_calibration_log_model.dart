class EquipmentCalibrationLogModel {
  final int? equipmentCalibrationLogId;
  final int equipmentId;
  final int client;
  final String date;
  final String methodOfCalibration;
  final String? reading;
  final int isCalibrationSatisfactory;
  final String media;
  final String? correctiveAction;
  final String? comment;
  final int deleted;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  int isSynced;
  String? deleteDate;

  EquipmentCalibrationLogModel({
    required this.equipmentCalibrationLogId,
    required this.equipmentId,
    required this.client,
    required this.date,
    required this.methodOfCalibration,
    required this.reading,
    required this.isCalibrationSatisfactory,
    required this.media,
    required this.correctiveAction,
    required this.comment,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.isSynced,
    this.deleteDate,
  });

  factory EquipmentCalibrationLogModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      EquipmentCalibrationLogModel(
        equipmentCalibrationLogId: map["equipment_calibration_log_id"],
        equipmentId: map["equipment_id"],
        client: map["client"],
        date: map["date"],
        methodOfCalibration: map["method_of_calibration"],
        reading: map["reading"],
        isCalibrationSatisfactory: map["is_calibration_satisfactory"],
        media: map["media"],
        correctiveAction: map["corrective_action"],
        comment: map["comment"],
        deleted: map["deleted"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: map["is_synced"],
        deleteDate: map["delete_date"],
      );

  Map<String, String?> toJson() {
    return {
      "client": client.toString(),
      "equipment_id": equipmentId.toString(),
      "date": date.toString(),
      "method_of_calibration": methodOfCalibration.toString(),
      "reading": reading?.toString(),
      "is_calibration_satisfactory": isCalibrationSatisfactory.toString(),
      "media": null,
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

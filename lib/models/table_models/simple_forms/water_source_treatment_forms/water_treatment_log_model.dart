class WaterTreatmentLogModel {
  final int? waterTreatmentLogId;
  final int client;
  final int farm;
  final String date;
  final String? description;
  final int isAccordingToWaterTreatmentWorkInstruction;
  final int isTreatmentEffective;
  final String? media;
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

  WaterTreatmentLogModel({
    required this.waterTreatmentLogId,
    required this.client,
    required this.farm,
    required this.date,
    required this.description,
    required this.isAccordingToWaterTreatmentWorkInstruction,
    required this.isTreatmentEffective,
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

  factory WaterTreatmentLogModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      WaterTreatmentLogModel(
        waterTreatmentLogId: map["water_treatment_log_id"],
        client: map["client"],
        farm: map["farm"],
        date: map["date"],
        description: map["description"],
        isAccordingToWaterTreatmentWorkInstruction:
            map["is_according_to_water_treatment_work_instruction"],
        isTreatmentEffective: map["is_treatment_effective"],
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
      "farm": farm.toString(),
      "date": date.toString(),
      "description": description?.toString(),
      "is_according_to_water_treatment_work_instruction":
          isAccordingToWaterTreatmentWorkInstruction.toString(),
      "is_treatment_effective": isTreatmentEffective.toString(),
      "media": null,
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

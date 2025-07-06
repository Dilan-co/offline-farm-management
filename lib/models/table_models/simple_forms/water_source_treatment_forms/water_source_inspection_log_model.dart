class WaterSourceInspectionLogModel {
  final int? waterSourceInspectionLogId;
  final int client;
  final int? farm;
  final String date;
  final String waterSourceName;
  final int isSecure;
  final int isAuthorizedAccessPermitted;
  final int isFreeFromContamination;
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

  WaterSourceInspectionLogModel({
    required this.waterSourceInspectionLogId,
    required this.client,
    required this.farm,
    required this.date,
    required this.waterSourceName,
    required this.isSecure,
    required this.isAuthorizedAccessPermitted,
    required this.isFreeFromContamination,
    required this.media,
    required this.correctiveAction,
    required this.comment,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.signature,
    required this.createdBySignature,
    required this.isSynced,
    this.deleteDate,
  });

  factory WaterSourceInspectionLogModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      WaterSourceInspectionLogModel(
        waterSourceInspectionLogId: map["water_source_inspection_log_id"],
        client: map["client"],
        farm: map["farm"],
        date: map["date"],
        waterSourceName: map["water_source_name"],
        isSecure: map["is_secure"],
        isAuthorizedAccessPermitted: map["is_authorized_access_permitted"],
        isFreeFromContamination: map["is_free_from_contamination"],
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
      "farm": farm?.toString(),
      "date": date.toString(),
      "water_source_name": waterSourceName.toString(),
      "is_secure": isSecure.toString(),
      "is_authorized_access_permitted": isAuthorizedAccessPermitted.toString(),
      "is_free_from_contamination": isFreeFromContamination.toString(),
      "media": null,
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

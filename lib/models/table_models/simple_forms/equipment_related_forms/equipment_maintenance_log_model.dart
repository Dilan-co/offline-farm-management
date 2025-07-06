class EquipmentMaintenanceLogModel {
  final int? equipmentMaintenanceLogId;
  final int equipmentId;
  final int client;
  final String? problem;
  final String? priority;
  final String? dateIdentified;
  final String? dateMaintenance;
  final String? media;
  final String? actionTaken;
  final String? externalContractor;
  final String? externalContractorDetails;
  final String? dateCompleted;
  final String? equipmentCleaned;
  final String? areaReleasedBy;
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

  EquipmentMaintenanceLogModel({
    required this.equipmentMaintenanceLogId,
    required this.equipmentId,
    required this.client,
    required this.problem,
    required this.priority,
    required this.dateIdentified,
    required this.dateMaintenance,
    required this.media,
    required this.actionTaken,
    required this.externalContractor,
    required this.externalContractorDetails,
    required this.dateCompleted,
    required this.equipmentCleaned,
    required this.areaReleasedBy,
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

  factory EquipmentMaintenanceLogModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      EquipmentMaintenanceLogModel(
        equipmentMaintenanceLogId: map["equipment_maintenance_log_id"],
        equipmentId: map["equipment_id"],
        client: map["client"],
        problem: map["problem"],
        priority: map["priority"],
        dateIdentified: map["date_identified"],
        dateMaintenance: map["date_maintenance"],
        media: map["media"],
        actionTaken: map["action_taken"],
        externalContractor: map["external_contractor"],
        externalContractorDetails: map["external_contractor_details"],
        dateCompleted: map["date_completed"],
        equipmentCleaned: map["equipment_cleaned"],
        areaReleasedBy: map["area_released_by"],
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
      "problem": problem?.toString(),
      "priority": priority?.toString(),
      "date_identified": dateIdentified?.toString(),
      "date_maintenance": dateMaintenance?.toString(),
      "media": null,
      "action_taken": actionTaken?.toString(),
      "external_contractor": externalContractor?.toString(),
      "external_contractor_details": externalContractorDetails?.toString(),
      "date_completed": dateCompleted?.toString(),
      "equipment_cleaned": equipmentCleaned?.toString(),
      "area_released_by": areaReleasedBy?.toString(),
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

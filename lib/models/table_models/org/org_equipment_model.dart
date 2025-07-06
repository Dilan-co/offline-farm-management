class OrgEquipmentModel {
  final int? equipmentId;
  final int client;
  final int equipmentTypeId;
  final int equipmentManufacturerId;
  final String? model;
  final String? serialNumber;
  final String name;
  final String label;
  final String? description;
  final String? manufactureYear;
  final String? dateOfPurchase;
  final String? personResponsible;
  final String? media;
  final int status;
  final String? comment;
  final int deleted;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  int isSynced;
  int readOnly;

  OrgEquipmentModel({
    required this.equipmentId,
    required this.client,
    required this.equipmentTypeId,
    required this.equipmentManufacturerId,
    required this.model,
    required this.serialNumber,
    required this.name,
    required this.label,
    required this.description,
    required this.manufactureYear,
    required this.dateOfPurchase,
    required this.personResponsible,
    required this.media,
    required this.status,
    required this.comment,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.isSynced,
    required this.readOnly,
  });

  factory OrgEquipmentModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      OrgEquipmentModel(
        equipmentId: map["equipment_id"],
        client: map["client"],
        equipmentTypeId: map["equipment_type_id"],
        equipmentManufacturerId: map["equipment_manufacturer_id"],
        model: map["model"],
        serialNumber: map["serial_number"],
        name: map["name"],
        label: map["label"],
        description: map["description"],
        manufactureYear: map["manufacture_year"],
        dateOfPurchase: map["date_of_purchase"],
        personResponsible: map["person_responsible"],
        media: map["media"],
        status: map["status"],
        comment: map["comment"],
        deleted: map["deleted"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: map["is_synced"],
        readOnly: map["read_only"],
      );

  factory OrgEquipmentModel.fromJson(Map<String, dynamic> map) =>
      OrgEquipmentModel(
        equipmentId: map["equipment_id"] is String
            ? int.tryParse(map["equipment_id"] ?? "")
            : map["equipment_id"],
        client: map["client"] is String
            ? int.tryParse(map["client"] ?? "0") ?? 0
            : map["client"] ?? 0,
        equipmentTypeId: map["equipment_type_id"] is String
            ? int.tryParse(map["equipment_type_id"] ?? "0") ?? 0
            : map["equipment_type_id"] ?? 0,
        equipmentManufacturerId: map["equipment_manufacturer_id"] is String
            ? int.tryParse(map["equipment_manufacturer_id"] ?? "0") ?? 0
            : map["equipment_manufacturer_id"] ?? 0,
        model: map["model"],
        serialNumber: map["serial_number"],
        name: map["name"] ?? "",
        label: map["label"] ?? "",
        description: map["description"],
        manufactureYear: map["manufacture_year"],
        dateOfPurchase: map["date_of_purchase"],
        personResponsible: map["person_responsible"],
        media: map["media"],
        status: map["status"] is String
            ? int.tryParse(map["status"] ?? "1") ?? 1
            : map["status"] ?? 1,
        comment: map["comment"] ?? "",
        deleted: map["deleted"] is String
            ? int.tryParse(map["deleted"] ?? "0") ?? 0
            : map["deleted"] ?? 0,
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"] is String
            ? int.tryParse(map["created_by"] ?? "")
            : map["created_by"],
        updatedBy: map["updated_by"] is String
            ? int.tryParse(map["updated_by"] ?? "")
            : map["updated_by"],
        createdBySignature: null,
        signature: null,
        isSynced: 1,
        readOnly: 1,
      );

  Map<String, String?> toJson() {
    return {
      "client": client.toString(),
      "equipment_type_id": equipmentTypeId.toString(),
      "equipment_manufacturer_id": equipmentManufacturerId.toString(),
      "model": model?.toString(),
      "serial_number": serialNumber?.toString(),
      "name": name.toString(),
      "label": label.toString(),
      "description": description?.toString(),
      "manufacture_year": manufactureYear?.toString(),
      "date_of_purchase": dateOfPurchase?.toString(),
      "person_responsible": personResponsible?.toString(),
      "media": null,
      "status": status.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

class OrgEquipmentTypeModel {
  final int? equipmentTypeId;
  final String name;
  final String? description;
  final int status;
  final int deleted;
  final int isSynced;

  OrgEquipmentTypeModel({
    required this.equipmentTypeId,
    required this.name,
    required this.description,
    required this.status,
    required this.deleted,
    required this.isSynced,
  });

  factory OrgEquipmentTypeModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      OrgEquipmentTypeModel(
        equipmentTypeId: map["equipment_type_id"],
        name: map["name"],
        description: map["description"],
        status: map["status"],
        deleted: map["deleted"],
        isSynced: map["is_synced"],
      );

  factory OrgEquipmentTypeModel.fromJson(Map<String, dynamic> map) =>
      OrgEquipmentTypeModel(
        equipmentTypeId: map["equipment_type_id"] is String
            ? int.tryParse(map["equipment_type_id"] ?? "")
            : map["equipment_type_id"],
        name: map["name"] ?? "",
        description: map["description"],
        status: map["status"] is String
            ? int.tryParse(map["status"] ?? "1") ?? 1
            : map["status"] ?? 1,
        deleted: map["deleted"] is String
            ? int.tryParse(map["deleted"] ?? "0") ?? 0
            : map["deleted"] ?? 0,
        isSynced: 1,
      );
}

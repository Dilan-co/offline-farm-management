class OrgEquipmentManufacturerModel {
  final int? equipmentManufacturerId;
  final String name;
  final String? phoneMobile;
  final String? phoneOfficeOne;
  final String? phoneOfficeTwo;
  final String email;
  final String? address;
  final String? state;
  final String country;
  final int status;
  final String? comment;
  final int deleted;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  final int isSynced;

  OrgEquipmentManufacturerModel({
    required this.equipmentManufacturerId,
    required this.name,
    required this.phoneMobile,
    required this.phoneOfficeOne,
    required this.phoneOfficeTwo,
    required this.email,
    required this.address,
    required this.state,
    required this.country,
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
  });

  factory OrgEquipmentManufacturerModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      OrgEquipmentManufacturerModel(
        equipmentManufacturerId: map["equipment_manufacturer_id"],
        name: map["name"],
        phoneMobile: map["phone_mobile"],
        phoneOfficeOne: map["phone_office_1"],
        phoneOfficeTwo: map["phone_office_2"],
        email: map["email"],
        address: map["address"],
        state: map["state"],
        country: map["country"],
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
      );

  factory OrgEquipmentManufacturerModel.fromJson(Map<String, dynamic> map) =>
      OrgEquipmentManufacturerModel(
        equipmentManufacturerId: map["equipment_manufacturer_id"] is String
            ? int.tryParse(map["equipment_manufacturer_id"] ?? "")
            : map["equipment_manufacturer_id"],
        name: map["name"] ?? "",
        phoneMobile: map["phone_mobile"],
        phoneOfficeOne: map["phone_office_1"],
        phoneOfficeTwo: map["phone_office_2"],
        email: map["email"] ?? "",
        address: map["address"],
        state: map["state"],
        country: map["country"] ?? "",
        status: map["status"] is String
            ? int.tryParse(map["status"] ?? "1") ?? 1
            : map["status"] ?? 1,
        comment: map["comment"],
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
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: 1,
      );
}

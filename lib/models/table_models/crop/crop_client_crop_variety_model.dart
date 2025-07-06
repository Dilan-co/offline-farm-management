class CropClientCropVarietyModel {
  final int? clientCropVarietyId;
  final int clientCropId;
  final String name;
  final String? code;
  final int? createdBy;
  final int? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? signature;
  final int isSynced;

  CropClientCropVarietyModel({
    required this.clientCropVarietyId,
    required this.clientCropId,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.signature,
    required this.isSynced,
  });

  factory CropClientCropVarietyModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      CropClientCropVarietyModel(
        clientCropVarietyId: map["client_crop_variety_id"],
        clientCropId: map["client_crop_id"],
        name: map["name"],
        code: map["code"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        signature: map["signature"],
        isSynced: map["is_synced"],
      );

  factory CropClientCropVarietyModel.fromJson(Map<String, dynamic> map) =>
      CropClientCropVarietyModel(
        clientCropVarietyId: map["client_crop_variety_id"] is String
            ? int.tryParse(map["client_crop_variety_id"] ?? "")
            : map["client_crop_variety_id"],
        clientCropId: map["client_crop_id"] is String
            ? int.tryParse(map["client_crop_id"] ?? "0") ?? 0
            : map["client_crop_id"] ?? 0,
        name: map["name"] ?? "",
        code: map["code"],
        createdBy: map["created_by"] is String
            ? int.tryParse(map["created_by"] ?? "")
            : map["created_by"],
        updatedBy: map["updated_by"] is String
            ? int.tryParse(map["updated_by"] ?? "")
            : map["updated_by"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        signature: map["signature"],
        isSynced: 1, // Always hardcoded to 1 as per your preference
      );
}

class CropClientCropModel {
  final int? clientCropId;
  final int clientId;
  final int cropId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  final int isSynced;

  CropClientCropModel({
    required this.clientCropId,
    required this.clientId,
    required this.cropId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.isSynced,
  });

  factory CropClientCropModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      CropClientCropModel(
        clientCropId: map["client_crop_id"],
        clientId: map["client_id"],
        cropId: map["crop_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: map["is_synced"],
      );

  factory CropClientCropModel.fromJson(Map<String, dynamic> map) =>
      CropClientCropModel(
        clientCropId: map["client_crop_id"] is String
            ? int.tryParse(map["client_crop_id"] ?? "")
            : map["client_crop_id"],
        clientId: map["client_id"] is String
            ? int.tryParse(map["client_id"] ?? "0") ?? 0
            : map["client_id"] ?? 0,
        cropId: map["crop_id"] is String
            ? int.tryParse(map["crop_id"] ?? "0") ?? 0
            : map["crop_id"] ?? 0,
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

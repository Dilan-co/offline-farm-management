class CropCropModel {
  final int? cropId;
  final String name;
  final int isSynced;

  CropCropModel({
    required this.cropId,
    required this.name,
    required this.isSynced,
  });

  factory CropCropModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      CropCropModel(
        cropId: map["crop_id"],
        name: map["name"],
        isSynced: map["is_synced"],
      );

  factory CropCropModel.fromJson(Map<String, dynamic> map) => CropCropModel(
        cropId: map["crop_id"] is String
            ? int.tryParse(map["crop_id"] ?? "")
            : map["crop_id"],
        name: map["name"] ?? "",
        isSynced: 1,
      );
}

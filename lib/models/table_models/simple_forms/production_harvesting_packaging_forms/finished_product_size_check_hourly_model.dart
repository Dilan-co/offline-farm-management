class FinishedProductSizeCheckHourlyModel {
  final int? finishedProductSizeCheckHourlyId;
  final int client;
  final int farm;
  final int crop;
  final int variety;
  final String date;
  final String? hourlySizeCheck;
  final String measurementUnit;
  final String? comment;
  final int userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  FinishedProductSizeCheckHourlyModel({
    required this.finishedProductSizeCheckHourlyId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.variety,
    required this.date,
    required this.hourlySizeCheck,
    required this.measurementUnit,
    required this.comment,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.signature,
    required this.isSynced,
    this.deleteDate,
  });

  factory FinishedProductSizeCheckHourlyModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      FinishedProductSizeCheckHourlyModel(
        finishedProductSizeCheckHourlyId:
            map["finished_product_size_check_hourly_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        variety: map["variety"],
        date: map["date"],
        hourlySizeCheck: map["hourly_size_check"],
        measurementUnit: map["measurement_unit"],
        comment: map["comment"],
        userId: map["user_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        signature: map["signature"],
        isSynced: map["is_synced"],
        deleteDate: map["delete_date"],
      );

  Map<String, String?> toJson() {
    return {
      "client": client.toString(),
      "farm": farm.toString(),
      "crop": crop.toString(),
      "variety": variety.toString(),
      "date": date.toString(),
      "hourly_size_check": hourlySizeCheck,
      "measurement_unit": measurementUnit.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

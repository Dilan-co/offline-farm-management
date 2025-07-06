class FinishedProductWeightCheckHourlyModel {
  final int? finishedProductWeightCheckHourlyId;
  final int client;
  final int farm;
  final int crop;
  final String date;
  final String? hourlyWeightCheck;
  final String? netWeight;
  final String? correctiveAction;
  final String? packagingTareWeight;
  final String? minimumGrossWeight;
  final String? packingLine;
  final String? comment;
  final int userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  FinishedProductWeightCheckHourlyModel({
    required this.finishedProductWeightCheckHourlyId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.date,
    required this.hourlyWeightCheck,
    required this.netWeight,
    required this.correctiveAction,
    required this.packagingTareWeight,
    required this.minimumGrossWeight,
    required this.packingLine,
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

  factory FinishedProductWeightCheckHourlyModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      FinishedProductWeightCheckHourlyModel(
        finishedProductWeightCheckHourlyId:
            map["finished_product_weight_check_hourly_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        date: map["date"],
        hourlyWeightCheck: map["hourly_weight_check"],
        netWeight: map["net_weight"],
        correctiveAction: map["corrective_action"],
        packagingTareWeight: map["packaging_tare_weight"],
        minimumGrossWeight: map["minimum_gross_weight"],
        packingLine: map["packing_line"],
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
      "date": date.toString(),
      "hourly_weight_check": hourlyWeightCheck,
      "net_weight": netWeight?.toString(),
      "packaging_tare_weight": packagingTareWeight?.toString(),
      "minimum_gross_weight": minimumGrossWeight?.toString(),
      "packing_line": packingLine?.toString(),
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

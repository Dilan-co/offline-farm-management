class InHouseLabelPrintingModel {
  final int? inHouseLabelPrintingId;
  final int client;
  final int farm;
  final int crop;
  final String? labelSampleOne;
  final String? packDate;
  final String? bestBeforeDate;
  final int? labelLegible;
  final String? correctiveAction;
  final String? comment;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  InHouseLabelPrintingModel({
    required this.inHouseLabelPrintingId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.labelSampleOne,
    required this.packDate,
    required this.bestBeforeDate,
    required this.labelLegible,
    required this.correctiveAction,
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

  factory InHouseLabelPrintingModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      InHouseLabelPrintingModel(
        inHouseLabelPrintingId: map["in_house_label_printing_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        labelSampleOne: map["label_sample_1"],
        packDate: map["pack_date"],
        bestBeforeDate: map["best_before_date"],
        labelLegible: map["lable_legible"],
        correctiveAction: map["corrective_action"],
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
      "label_sample_1": null,
      "pack_date": packDate?.toString(),
      "best_before_date": bestBeforeDate?.toString(),
      "label_legible": labelLegible.toString(),
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

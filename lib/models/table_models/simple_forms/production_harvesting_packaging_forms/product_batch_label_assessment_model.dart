class ProductionBatchLabelAssessmentModel {
  final int? productionBatchLabelAssessmentId;
  final int client;
  final int farm;
  final int crop;
  final String productionBatchNumber;
  final String? variety;
  final String packDate;
  final String? startTime;
  final String? endTime;
  final String? labelSampleOne;
  final String? packDateOne;
  final String? bestBeforeDateOne;
  final int? labelPositionOne;
  final int? labelLegibleOne;
  final String? labelSampleTwo;
  final String? packDateTwo;
  final String? bestBeforeDateTwo;
  final int? labelPositionTwo;
  final int? labelLegibleTwo;
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

  ProductionBatchLabelAssessmentModel({
    required this.productionBatchLabelAssessmentId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.productionBatchNumber,
    required this.variety,
    required this.packDate,
    required this.startTime,
    required this.endTime,
    required this.labelSampleOne,
    required this.packDateOne,
    required this.bestBeforeDateOne,
    required this.labelPositionOne,
    required this.labelLegibleOne,
    required this.labelSampleTwo,
    required this.packDateTwo,
    required this.bestBeforeDateTwo,
    required this.labelPositionTwo,
    required this.labelLegibleTwo,
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

  factory ProductionBatchLabelAssessmentModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      ProductionBatchLabelAssessmentModel(
        productionBatchLabelAssessmentId:
            map["production_batch_label_assessment_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        productionBatchNumber: map["production_batch_number"],
        variety: map["variety"],
        packDate: map["pack_date"],
        startTime: map["start_time"],
        endTime: map["end_time"],
        labelSampleOne: map["label_sample_01"],
        packDateOne: map["pack_date_01"],
        bestBeforeDateOne: map["best_before_date_01"],
        labelPositionOne: map["label_position_01"],
        labelLegibleOne: map["label_legible_01"],
        labelSampleTwo: map["label_sample_02"],
        packDateTwo: map["pack_date_02"],
        bestBeforeDateTwo: map["best_before_date_02"],
        labelPositionTwo: map["label_position_02"],
        labelLegibleTwo: map["label_legible_02"],
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
      "production_batch_number": productionBatchNumber.toString(),
      "variety": variety?.toString(),
      "pack_date": packDate.toString(),
      "start_time": startTime?.toString(),
      "end_time": endTime?.toString(),
      "label_sample_01": null,
      "pack_date_01": packDateOne?.toString(),
      "best_before_date_01": bestBeforeDateOne?.toString(),
      "label_position_01": labelPositionOne?.toString(),
      "label_legible_01": labelLegibleOne?.toString(),
      "label_sample_02": null,
      "pack_date_02": packDateTwo?.toString(),
      "best_before_date_02": bestBeforeDateTwo?.toString(),
      "label_position_02": labelPositionTwo?.toString(),
      "label_legible_02": labelLegibleTwo?.toString(),
      "corrective_action": correctiveAction?.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

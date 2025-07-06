class HarvestRiskAssessmentModel {
  final int? harvestRiskAssessmentId;
  final int client;
  final int farm;
  final int crop;
  final String? blockRange;
  final String harvestDate;
  final String? lastSprayDateTime;
  final String? sprayedWith;
  final String? withholdPeriodApplied;
  final String? safeDateToHarvest;
  final String? harvestAuthorizedBy;
  final String? comment;
  final int userId;
  final String createdAt;
  final String? updatedAt;
  final int createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  HarvestRiskAssessmentModel({
    required this.harvestRiskAssessmentId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.blockRange,
    required this.harvestDate,
    required this.lastSprayDateTime,
    required this.sprayedWith,
    required this.withholdPeriodApplied,
    required this.safeDateToHarvest,
    required this.harvestAuthorizedBy,
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

  factory HarvestRiskAssessmentModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      HarvestRiskAssessmentModel(
        harvestRiskAssessmentId: map["harvest_risk_assessment_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        blockRange: map["block_range"],
        harvestDate: map["harvest_date"],
        lastSprayDateTime: map["last_spay_date_time"],
        sprayedWith: map["sprayed_with"],
        withholdPeriodApplied: map["withhold_period_applied"],
        safeDateToHarvest: map["safe_date_to_harvest"],
        harvestAuthorizedBy: map["harvest_authorised_by"],
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
      "block_range": blockRange.toString(),
      "harvest_date": harvestDate.toString(),
      "last_spay_date_time": lastSprayDateTime.toString(),
      "sprayed_with": sprayedWith.toString(),
      "withhold_period_applied": withholdPeriodApplied.toString(),
      "safe_date_to_harvest": safeDateToHarvest.toString(),
      "harvest_authorised_by": harvestAuthorizedBy.toString(),
      "comment": comment.toString(),
      "signature": null,
    };
  }
}

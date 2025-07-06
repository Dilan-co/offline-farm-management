class PackagingTareWeightCheckModel {
  final int? packagingTareWeightCheckId;
  final int client;
  final int farm;
  final int crop;
  final String packagingFormat;
  final String grossWeightOfFinishedProduct;
  final String? weightOfOuterPackaging;
  final String? weightOfLiner;
  final String? weightOfPrimaryPackaging;
  final String totalWeightOfPackaging;
  final String netWeightOfProduct;
  final String? weightClaimedOnLabelOrPackaging;
  final int checkWeightAgain;
  final String? comment;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? signature;
  int isSynced;
  String? deleteDate;

  PackagingTareWeightCheckModel({
    required this.packagingTareWeightCheckId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.packagingFormat,
    required this.grossWeightOfFinishedProduct,
    required this.weightOfOuterPackaging,
    required this.weightOfLiner,
    required this.weightOfPrimaryPackaging,
    required this.totalWeightOfPackaging,
    required this.netWeightOfProduct,
    required this.weightClaimedOnLabelOrPackaging,
    required this.checkWeightAgain,
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

  factory PackagingTareWeightCheckModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      PackagingTareWeightCheckModel(
        packagingTareWeightCheckId: map["packaging_tare_weight_check_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        packagingFormat: map["packaging_format"],
        grossWeightOfFinishedProduct: map["gross_weight_of_finished_product"],
        weightOfOuterPackaging: map["weight_of_outer_packaging"],
        weightOfLiner: map["weight_of_liner"],
        weightOfPrimaryPackaging: map["weight_of_primary_packaging"],
        totalWeightOfPackaging: map["total_weight_of_packaging"],
        netWeightOfProduct: map["nett_weight_of_product"],
        weightClaimedOnLabelOrPackaging:
            map["weight_claimed_on_label_or_packaging"],
        checkWeightAgain: map["check_weight_again"],
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
      "packaging_format": packagingFormat.toString(),
      "gross_weight_of_finished_product":
          grossWeightOfFinishedProduct.toString(),
      "weight_of_outer_packaging": weightOfOuterPackaging?.toString(),
      "weight_of_liner": weightOfLiner?.toString(),
      "weight_of_primary_packaging": weightOfPrimaryPackaging?.toString(),
      "total_weight_of_packaging": totalWeightOfPackaging.toString(),
      "net_weight_of_product": netWeightOfProduct.toString(),
      "weight_claimed_on_label_or_packaging":
          weightClaimedOnLabelOrPackaging?.toString(),
      "check_weight_again": checkWeightAgain.toString(),
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

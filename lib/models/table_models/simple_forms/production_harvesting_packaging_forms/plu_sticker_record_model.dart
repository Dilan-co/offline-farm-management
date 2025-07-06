class PluStickerRecordModel {
  final int? pluStickerId;
  final int client;
  final int farm;
  final int crop;
  final String date;
  final String? time;
  final String? cassetteNumber;
  final int lineClearance;
  final String? pluNew;
  final String? pluOld;
  final String? comment;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String signature;
  int isSynced;
  String? deleteDate;

  PluStickerRecordModel({
    required this.pluStickerId,
    required this.client,
    required this.farm,
    required this.crop,
    required this.date,
    required this.time,
    required this.cassetteNumber,
    required this.lineClearance,
    required this.pluNew,
    required this.pluOld,
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

  factory PluStickerRecordModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      PluStickerRecordModel(
        pluStickerId: map["plu_sticker_id"],
        client: map["client"],
        farm: map["farm"],
        crop: map["crop"],
        date: map["date"],
        time: map["time"],
        cassetteNumber: map["cassette_number"],
        lineClearance: map["line_clearance"],
        pluNew: map["plu_new"],
        pluOld: map["plu_old"],
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
      "time": time?.toString(),
      "cassette_number": cassetteNumber?.toString(),
      "line_clearance": lineClearance.toString(),
      "plu_new": null,
      "plu_old": null,
      "comment": comment?.toString(),
      "signature": null,
    };
  }
}

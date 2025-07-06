class OrgClientModel {
  final int? clientId;
  final int clientTypeId;
  final String? name;
  final String businessLegalName;
  final String businessAbn;
  final int isSimpleClient;
  final String? status;
  final String? email;
  final String? createdDate;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  final int isSynced;

  OrgClientModel({
    required this.clientId,
    required this.clientTypeId,
    required this.name,
    required this.businessLegalName,
    required this.businessAbn,
    required this.isSimpleClient,
    required this.status,
    required this.email,
    required this.createdDate,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.isSynced,
  });

  factory OrgClientModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      OrgClientModel(
        clientId: map["client_id"],
        clientTypeId: map["client_type_id"],
        name: map["name"],
        businessLegalName: map["business_legal_name"],
        businessAbn: map["business_abn"],
        isSimpleClient: map["is_simple_client"],
        status: map["status"],
        email: map["email"],
        createdDate: map["created_date"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: map["is_synced"],
      );

  factory OrgClientModel.fromJson(Map<String, dynamic> map) => OrgClientModel(
        clientId: map["client_id"] is String
            ? int.tryParse(map["client_id"] ?? "")
            : map["client_id"],
        clientTypeId: map["client_type_id"] is String
            ? int.tryParse(map["client_type_id"] ?? "0") ?? 0
            : map["client_type_id"] ?? 0,
        name: map["name"],
        businessLegalName: map["business_legal_name"] ?? "",
        businessAbn: map["business_abn"] ?? "",
        isSimpleClient: map["is_simple_client"] is String
            ? int.tryParse(map["is_simple_client"] ?? "0") ?? 0
            : map["is_simple_client"] ?? 0,
        status: map["status"],
        email: map["email"],
        createdDate: map["created_date"],
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

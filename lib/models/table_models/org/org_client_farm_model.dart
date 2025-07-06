class OrgClientFarmModel {
  final int? clientFarmId;
  final int clientId;
  final String name;
  final String? description;
  final int? size;
  final String? streetNo;
  final String? streetName;
  final String? city;
  final String? state;
  final String? postCode;
  final String? country;
  final String? mapCoordinates;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  final int isSynced;

  OrgClientFarmModel({
    required this.clientFarmId,
    required this.clientId,
    required this.name,
    required this.description,
    required this.size,
    required this.streetNo,
    required this.streetName,
    required this.city,
    required this.state,
    required this.postCode,
    required this.country,
    required this.mapCoordinates,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.isSynced,
  });

  factory OrgClientFarmModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      OrgClientFarmModel(
        clientFarmId: map["client_farm_id"],
        clientId: map["client_id"],
        name: map["name"],
        description: map["description"],
        size: map["size"],
        streetNo: map["street_no"],
        streetName: map["street_name"],
        city: map["city"],
        state: map["state"],
        postCode: map["postcode"],
        country: map["country"],
        mapCoordinates: map["map_coodinates"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        isSynced: map["is_synced"],
      );

  factory OrgClientFarmModel.fromJson(Map<String, dynamic> map) =>
      OrgClientFarmModel(
        clientFarmId: map["client_farm_id"] is String
            ? int.tryParse(map["client_farm_id"] ?? "")
            : map["client_farm_id"],
        clientId: map["client_id"] is String
            ? int.tryParse(map["client_id"] ?? "0") ?? 0
            : map["client_id"] ?? 0,
        name: map["name"] ?? "",
        description: map["description"],
        size: map["size"] is String
            ? int.tryParse(map["size"] ?? "")
            : map["size"],
        streetNo: map["street_no"],
        streetName: map["street_name"],
        city: map["city"],
        state: map["state"],
        postCode: map["postcode"],
        country: map["country"],
        mapCoordinates: map["map_coodinates"],
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

class OrgChemicalProductModel {
  final int? chemicalProductId;
  final int client;
  final String name;
  final String brandName;
  final int isSynced;
  int readOnly;

  OrgChemicalProductModel({
    required this.chemicalProductId,
    required this.client,
    required this.name,
    required this.brandName,
    required this.isSynced,
    required this.readOnly,
  });

  factory OrgChemicalProductModel.fromSqfliteDatabase(
          Map<String, dynamic> map) =>
      OrgChemicalProductModel(
        chemicalProductId: map["chemical_product_id"],
        client: map["client"],
        name: map["name"],
        brandName: map["brand_name"],
        isSynced: map["is_synced"],
        readOnly: map["read_only"],
      );

  factory OrgChemicalProductModel.fromJson(Map<String, dynamic> map) =>
      OrgChemicalProductModel(
        chemicalProductId: map["chemical_product_id"] is String
            ? int.tryParse(map["chemical_product_id"] ?? "")
            : map["chemical_product_id"],
        client: map["client"] is String
            ? int.tryParse(map["client"] ?? "0") ?? 0
            : map["client"] ?? 0,
        name: map["name"] ?? "",
        brandName: map["brand_name"] ?? "",
        isSynced: 1,
        readOnly: 1,
      );
}

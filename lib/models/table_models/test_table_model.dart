class TestTableModel {
  final int id;
  final String firstName;
  final String? lastName;
  final String city;
  final String createdAt;

  TestTableModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.city,
    required this.createdAt,
  });

  factory TestTableModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      TestTableModel(
        id: map["id"] ?? 0,
        firstName: map["first_name"] ?? "",
        lastName: map["last_name"] ?? "",
        city: map["city"] ?? "",
        createdAt: map["created_at"]?.toString() ?? "",
      );
}

class UserModel {
  final int? userId;
  final String username;
  final String password;
  final String? pinCode;
  final String displayName;
  final String firstName;
  final String lastName;
  final String userType;
  final String title;
  final String email;
  final String? telephone;
  final String mobile;
  final String? fax;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final String? createdBySignature;
  final String? signature;
  final int deleted;
  final int isSynced;

  UserModel({
    required this.userId,
    required this.username,
    required this.password,
    required this.pinCode,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.title,
    required this.email,
    required this.telephone,
    required this.mobile,
    required this.fax,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.createdBySignature,
    required this.signature,
    required this.deleted,
    required this.isSynced,
  });

  factory UserModel.fromSqfliteDatabase(Map<String, dynamic> map) => UserModel(
        userId: map["user_id"],
        username: map["username"],
        password: map["password"],
        pinCode: map["pin_code"],
        displayName: map["displayname"],
        firstName: map["first_name"],
        lastName: map["last_name"],
        userType: map["user_type"],
        title: map["title"],
        email: map["email"],
        telephone: map["telephone"],
        mobile: map["mobile"],
        fax: map["fax"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        createdBy: map["created_by"],
        updatedBy: map["updated_by"],
        createdBySignature: map["created_by_signature"],
        signature: map["signature"],
        deleted: map["deleted"],
        isSynced: map["is_synced"],
      );

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        userId: map["user_id"] is String
            ? int.tryParse(map["user_id"] ?? "")
            : map["user_id"],
        username: map["username"] ?? "",
        password: map["password"] ?? "",
        pinCode: map["pin_code"],
        displayName: map["displayname"] ?? "",
        firstName: map["first_name"] ?? "",
        lastName: map["last_name"] ?? "",
        userType: map["user_type"] ?? "",
        title: map["title"] ?? "",
        email: map["email"] ?? "",
        telephone: map["telephone"],
        mobile: map["mobile"] ?? "",
        fax: map["fax"],
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
        deleted: map["deleted"] is String
            ? int.tryParse(map["deleted"] ?? "0") ?? 0
            : map["deleted"] ?? 0, // Handle null value with default 0
        isSynced: 1,
      );
}

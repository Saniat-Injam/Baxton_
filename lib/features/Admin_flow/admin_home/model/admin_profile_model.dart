import 'dart:convert';

Adminprofile adminprofileFromJson(String str) => Adminprofile.fromJson(json.decode(str));

String adminprofileToJson(Adminprofile data) => json.encode(data.toJson());

class Adminprofile {
  bool success;
  String message;
  Data data;

  Adminprofile({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Adminprofile.fromJson(Map<String, dynamic> json) => Adminprofile(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;

  Data({
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  String id;
  String email;
  String phone;
  String name;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;
  String userType;
  bool active;
  AdminProfile adminProfile;
  bool isProfileCreated;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
    required this.active,
    required this.adminProfile,
    required this.isProfileCreated,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    phone: json["phone"],
    name: json["name"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userType: json["UserType"],
    active: json["active"],
    adminProfile: AdminProfile.fromJson(json["adminProfile"]),
    isProfileCreated: json["isProfileCreated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phone": phone,
    "name": name,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "UserType": userType,
    "active": active,
    "adminProfile": adminProfile.toJson(),
    "isProfileCreated": isProfileCreated,
  };
}

class AdminProfile {
  String id;
  String userId;

  AdminProfile({
    required this.id,
    required this.userId,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) => AdminProfile(
    id: json["id"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
  };
}
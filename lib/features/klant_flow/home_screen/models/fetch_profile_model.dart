import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  bool success;
  String message;
  Data data;

  Profile({required this.success, required this.message, required this.data});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: Data.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;

  Data({required this.user});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(user: User.fromJson(json["user"] ?? {}));

  Map<String, dynamic> toJson() => {"user": user.toJson()};
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
  ClientProfile clientProfile;
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
    required this.clientProfile,
    required this.isProfileCreated,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    name: json["name"] ?? json["fullName"] ?? "Unknown", // Fallback for name
    isVerified: json["isVerified"] ?? false,
    createdAt: DateTime.parse(
      json["createdAt"] ?? DateTime.now().toIso8601String(),
    ),
    updatedAt: DateTime.parse(
      json["updatedAt"] ?? DateTime.now().toIso8601String(),
    ),
    userType: json["UserType"] ?? "",
    active: json["active"] ?? false,
    clientProfile: ClientProfile.fromJson(json["clientProfile"] ?? {}),
    isProfileCreated: json["isProfileCreated"] ?? false,
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
    "clientProfile": clientProfile.toJson(),
    "isProfileCreated": isProfileCreated,
  };
}

class ClientProfile {
  String id;
  String userId;
  String location;
  String userName;
  ProfilePic profilePic;

  ClientProfile({
    required this.id,
    required this.userId,
    required this.location,
    required this.userName,
    required this.profilePic,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
    id: json["id"] ?? "",
    userId: json["userId"] ?? "",
    location: json["location"] ?? "",
    userName: json["userName"] ?? "",
    profilePic: ProfilePic.fromJson(json["profilePic"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "location": location,
    "userName": userName,
    "profilePic": profilePic.toJson(),
  };
}

class ProfilePic {
  String url;

  ProfilePic({required this.url});

  factory ProfilePic.fromJson(Map<String, dynamic> json) =>
      ProfilePic(url: json["url"] ?? "");

  bool get isNotEmpty => url.isNotEmpty;

  Map<String, dynamic> toJson() => {"url": url};
}

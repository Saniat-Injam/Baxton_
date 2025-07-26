
import 'dart:convert';

Allemploye allemployeFromJson(String str) => Allemploye.fromJson(json.decode(str));

String allemployeToJson(Allemploye data) => json.encode(data.toJson());

class Allemploye {
  List<Datum> data;
  String message;
  bool success;

  Allemploye({
    required this.data,
    required this.message,
    required this.success,
  });

  factory Allemploye.fromJson(Map<String, dynamic> json) => Allemploye(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class Datum {
  String? id; // Made nullable
  String? userId; // Made nullable
  String? userName; // Made nullable for safety
  String? workerId; // Made nullable for safety
  dynamic location;
  String? workerSpecialistId;
  User? user; // Made nullable
  ProfilePic? profilePic;
  WorkerSpecialist? workerSpecialist;

  Datum({
    this.id,
    this.userId,
    this.userName,
    this.workerId,
    required this.location,
    this.workerSpecialistId,
    this.user,
    this.profilePic,
    this.workerSpecialist,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "", // Default to empty string if null
        userId: json["userId"], // Nullable
        userName: json["userName"] ?? "", // Default to empty string if null
        workerId: json["workerId"] ?? "", // Default to empty string if null
        location: json["location"],
        workerSpecialistId: json["workerSpecialistId"],
        user: json["User"] == null ? null : User.fromJson(json["User"]),
        profilePic: json["profilePic"] == null ? null : ProfilePic.fromJson(json["profilePic"]),
        workerSpecialist: json["WorkerSpecialist"] == null ? null : WorkerSpecialist.fromJson(json["WorkerSpecialist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "workerId": workerId,
        "location": location,
        "workerSpecialistId": workerSpecialistId,
        "User": user?.toJson(),
        "profilePic": profilePic?.toJson(),
        "WorkerSpecialist": workerSpecialist?.toJson(),
      };
}

class ProfilePic {
  String url;

  ProfilePic({
    required this.url,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class User {
  String? name; // Made nullable

  User({
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? "", // Default to empty string if null
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class WorkerSpecialist {
  String name;
  String id;

  WorkerSpecialist({
    required this.name,
    required this.id,
  });

  factory WorkerSpecialist.fromJson(Map<String, dynamic> json) => WorkerSpecialist(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

// ignore_for_file: prefer_null_aware_operators
import 'dart:convert';
Workerdetails workerdetailsFromJson(String str) => Workerdetails.fromJson(json.decode(str));

String workerdetailsToJson(Workerdetails data) => json.encode(data.toJson());

class Workerdetails {
  bool success;
  String message;
  Data data;

  Workerdetails({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Workerdetails.fromJson(Map<String, dynamic> json) => Workerdetails(
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
  String id;
  String userId;
  String userName;
  String workerId;
  String? location; // Changed to String? to allow null
  String? workerSpecialistId; // Changed to String? to allow null
  User user;
  ProfilePic? profilePic; // Changed to ProfilePic? to allow null
  WorkerSpecialist? workerSpecialist; // Changed to WorkerSpecialist? to allow null
  List<AssignedService> assignedService;
  int totalAssigned;
  int totalCompleted;
  int totalPending;
  int averageRating;

  Data({
    required this.id,
    required this.userId,
    required this.userName,
    required this.workerId,
    this.location,
    this.workerSpecialistId,
    required this.user,
    this.profilePic,
    this.workerSpecialist,
    required this.assignedService,
    required this.totalAssigned,
    required this.totalCompleted,
    required this.totalPending,
    required this.averageRating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"]?.toString() ?? "",
        userId: json["userId"]?.toString() ?? "",
        userName: json["userName"]?.toString() ?? "",
        workerId: json["workerId"]?.toString() ?? "",
        location: json["location"] is String
            ? json["location"]
            : json["location"] != null
                ? json["location"].toString()
                : null, // Handle Map or null
        workerSpecialistId: json["workerSpecialistId"]?.toString(),
        user: User.fromJson(json["User"] ?? {}),
        profilePic: json["profilePic"] != null
            ? ProfilePic.fromJson(json["profilePic"])
            : null,
        workerSpecialist: json["WorkerSpecialist"] != null
            ? WorkerSpecialist.fromJson(json["WorkerSpecialist"])
            : null,
        assignedService: List<AssignedService>.from(
            (json["assignedService"] ?? []).map((x) => AssignedService.fromJson(x))),
        totalAssigned: json["totalAssigned"]?.toInt() ?? 0,
        totalCompleted: json["totalCompleted"]?.toInt() ?? 0,
        totalPending: json["totalPending"]?.toInt() ?? 0,
        averageRating: json["averageRating"]?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "workerId": workerId,
        "location": location,
        "workerSpecialistId": workerSpecialistId,
        "User": user.toJson(),
        "profilePic": profilePic?.toJson(),
        "WorkerSpecialist": workerSpecialist?.toJson(),
        "assignedService": List<dynamic>.from(assignedService.map((x) => x.toJson())),
        "totalAssigned": totalAssigned,
        "totalCompleted": totalCompleted,
        "totalPending": totalPending,
        "averageRating": averageRating,
      };
}

class AssignedService {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String phoneNumber;
  String email;
  String city;
  String postalCode;
  String locationDescription;
  String problemDescription;
  DateTime preferredTime;
  DateTime preferredDate;
  String status;
  int basePrice;
  String workerProfileId;
  dynamic invoiceId;
  dynamic clientProfileId;
  String taskTypeId;
  String paymentType;
  int rating;
  dynamic review;
  bool accept;

  AssignedService({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.postalCode,
    required this.locationDescription,
    required this.problemDescription,
    required this.preferredTime,
    required this.preferredDate,
    required this.status,
    required this.basePrice,
    required this.workerProfileId,
    required this.invoiceId,
    required this.clientProfileId,
    required this.taskTypeId,
    required this.paymentType,
    required this.rating,
    required this.review,
    required this.accept,
  });

  factory AssignedService.fromJson(Map<String, dynamic> json) => AssignedService(
        id: json["id"]?.toString() ?? "",
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
        name: json["name"]?.toString() ?? "",
        phoneNumber: json["phoneNumber"]?.toString() ?? "",
        email: json["email"]?.toString() ?? "",
        city: json["city"]?.toString() ?? "",
        postalCode: json["postalCode"]?.toString() ?? "",
        locationDescription: json["locationDescription"]?.toString() ?? "",
        problemDescription: json["problemDescription"]?.toString() ?? "",
        preferredTime: json["preferredTime"] != null ? DateTime.parse(json["preferredTime"]) : DateTime.now(),
        preferredDate: json["preferredDate"] != null ? DateTime.parse(json["preferredDate"]) : DateTime.now(),
        status: json["status"]?.toString() ?? "",
        basePrice: json["basePrice"]?.toInt() ?? 0,
        workerProfileId: json["workerProfileId"]?.toString() ?? "",
        invoiceId: json["invoiceId"],
        clientProfileId: json["clientProfileId"],
        taskTypeId: json["taskTypeId"]?.toString() ?? "",
        paymentType: json["paymentType"]?.toString() ?? "",
        rating: json["rating"]?.toInt() ?? 0,
        review: json["review"],
        accept: json["accept"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "city": city,
        "postalCode": postalCode,
        "locationDescription": locationDescription,
        "problemDescription": problemDescription,
        "preferredTime": preferredTime.toIso8601String(),
        "preferredDate": preferredDate.toIso8601String(),
        "status": status,
        "basePrice": basePrice,
        "workerProfileId": workerProfileId,
        "invoiceId": invoiceId,
        "clientProfileId": clientProfileId,
        "taskTypeId": taskTypeId,
        "paymentType": paymentType,
        "rating": rating,
        "review": review,
        "accept": accept,
      };
}

class ProfilePic {
  String url;

  ProfilePic({
    required this.url,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        url: json["url"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class User {
  String id;
  String email;
  String phone;

  User({
    required this.id,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"]?.toString() ?? "",
        email: json["email"]?.toString() ?? "",
        phone: json["phone"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
      };
}

class WorkerSpecialist {
  String name;

  WorkerSpecialist({
    required this.name,
  });

  factory WorkerSpecialist.fromJson(Map<String, dynamic> json) => WorkerSpecialist(
        name: json["name"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
import 'dart:convert';

ApiEmployeeResponse apiEmployeeResponseFromJson(String str) =>
    ApiEmployeeResponse.fromJson(json.decode(str));

class ApiEmployeeResponse {
  List<ApiEmployee> data;
  String message;
  bool success;

  ApiEmployeeResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory ApiEmployeeResponse.fromJson(Map<String, dynamic> json) =>
      ApiEmployeeResponse(
        data: List<ApiEmployee>.from(
            (json["data"] as List).map((x) => ApiEmployee.fromJson(x))),
        message: json["message"] ?? '',
        success: json["success"] ?? false,
      );
}

class ApiEmployee {
  String id;
  String userId;
  String userName;
  String workerId;
  String location;
  String workerSpecialistId;
  String isActive;
  User user;
  ProfilePic profilePic;
  WorkerSpecialist workerSpecialist;

  ApiEmployee({
    required this.id,
    required this.userId,
    required this.userName,
    required this.workerId,
    required this.location,
    required this.workerSpecialistId,
    required this.isActive,
    required this.user,
    required this.profilePic,
    required this.workerSpecialist,
  });

  factory ApiEmployee.fromJson(Map<String, dynamic> json) => ApiEmployee(
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        userName: json["userName"] ?? '',
        workerId: json["workerId"] ?? '',
        location: json["location"] ?? '',
        workerSpecialistId: json["workerSpecialistId"] ?? '',
        isActive: json["isActive"] ?? '',
        user: User.fromJson(json["User"]), // Make sure it's capital "User"
        profilePic: ProfilePic.fromJson(json["profilePic"]),
        workerSpecialist: WorkerSpecialist.fromJson(json["WorkerSpecialist"]),
      );
}

class User {
  String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? '',
      );
}

class ProfilePic {
  String url;

  ProfilePic({required this.url});

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        url: json["url"] ?? '',
      );
}

class WorkerSpecialist {
  String name;
  String id;

  WorkerSpecialist({required this.name, required this.id});

  factory WorkerSpecialist.fromJson(Map<String, dynamic> json) =>
      WorkerSpecialist(
        name: json["name"] ?? '',
        id: json["id"] ?? '',
      );
}

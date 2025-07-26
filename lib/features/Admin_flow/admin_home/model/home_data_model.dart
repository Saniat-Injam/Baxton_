
// import 'dart:convert';

// Homedata homedataFromJson(String str) => Homedata.fromJson(json.decode(str));

// String homedataToJson(Homedata data) => json.encode(data.toJson());

// class Homedata {
//   Data data;
//   String message;
//   bool success;

//   Homedata({required this.data, required this.message, required this.success});

//   factory Homedata.fromJson(Map<String, dynamic> json) => Homedata(
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "message": message,
//         "success": success,
//       };
// }

// class Data {
//   TaskStatistics taskStatistics;
//   List<FirstThreeTask> firstThreeTasks;
//   int totalWorkers;
//   AverageRating averageRating;

//   Data({
//     required this.taskStatistics,
//     required this.firstThreeTasks,
//     required this.totalWorkers,
//     required this.averageRating,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         taskStatistics: TaskStatistics.fromJson(json["taskStatistics"]),
//         firstThreeTasks: List<FirstThreeTask>.from(
//           json["firstThreeTasks"].map((x) => FirstThreeTask.fromJson(x)),
//         ),
//         totalWorkers: json["totalWorkers"],
//         averageRating: AverageRating.fromJson(json["averageRating"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "taskStatistics": taskStatistics.toJson(),
//         "firstThreeTasks": List<dynamic>.from(
//           firstThreeTasks.map((x) => x.toJson()),
//         ),
//         "totalWorkers": totalWorkers,
//         "averageRating": averageRating.toJson(),
//       };
// }

// class AverageRating {
//   Avg avg;

//   AverageRating({required this.avg});

//   factory AverageRating.fromJson(Map<String, dynamic> json) =>
//       AverageRating(avg: Avg.fromJson(json["_avg"]));

//   Map<String, dynamic> toJson() => {"_avg": avg.toJson()};
// }

// class Avg {
//   double rating;

//   Avg({required this.rating});

//   factory Avg.fromJson(Map<String, dynamic> json) =>
//       Avg(rating: ((json["rating"] ?? 0) as num).toDouble());

//   Map<String, dynamic> toJson() => {
//         "rating": double.parse(rating.toStringAsFixed(2)),
//       };
// }



// class FirstThreeTask {
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String name;
//   String phoneNumber;
//   String email;
//   String city;
//   String postalCode;
//   String locationDescription;
//   String problemDescription;
//   DateTime preferredTime;
//   DateTime preferredDate;
//   String status;
//   int basePrice;
//   dynamic workerProfileId;
//   dynamic invoiceId;
//   String clientProfileId;
//   String? taskTypeId;
//   String paymentType;
//   int rating;
//   dynamic review;
//   bool accept;
//   TaskType? taskType;
//   WorkerProfile? workerProfile;
//   String? createdAtFormatted;

//   FirstThreeTask({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.name,
//     required this.phoneNumber,
//     required this.email,
//     required this.city,
//     required this.postalCode,
//     required this.locationDescription,
//     required this.problemDescription,
//     required this.preferredTime,
//     required this.preferredDate,
//     required this.status,
//     required this.basePrice,
//     required this.workerProfileId,
//     required this.invoiceId,
//     required this.clientProfileId,
//     this.taskTypeId,
//     required this.paymentType,
//     required this.rating,
//     required this.review,
//     required this.accept,
//     this.taskType,
//     this.workerProfile,
//     this.createdAtFormatted,
//   });

//   factory FirstThreeTask.fromJson(Map<String, dynamic> json) => FirstThreeTask(
//         id: json["id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         name: json["name"],
//         phoneNumber: json["phoneNumber"],
//         email: json["email"],
//         city: json["city"],
//         postalCode: json["postalCode"],
//         locationDescription: json["locationDescription"],
//         problemDescription: json["problemDescription"],
//         preferredTime: DateTime.parse(json["preferredTime"]),
//         preferredDate: DateTime.parse(json["preferredDate"]),
//         status: json["status"],
//         basePrice: json["basePrice"],
//         workerProfileId: json["workerProfileId"],
//         invoiceId: json["invoiceId"],
//         clientProfileId: json["clientProfileId"],
//         taskTypeId: json["taskTypeId"],
//         paymentType: json["paymentType"],
//         rating: json["rating"],
//         review: json["review"],
//         accept: json["accept"],
//         taskType: json["TaskType"] != null
//             ? TaskType.fromJson(json["TaskType"])
//             : null,
//         workerProfile: json["WorkerProfile"] != null
//             ? WorkerProfile.fromJson(json["WorkerProfile"])
//             : null,
//         createdAtFormatted: json["createdAtFormatted"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "name": name,
//         "phoneNumber": phoneNumber,
//         "email": email,
//         "city": city,
//         "postalCode": postalCode,
//         "locationDescription": locationDescription,
//         "problemDescription": problemDescription,
//         "preferredTime": preferredTime.toIso8601String(),
//         "preferredDate": preferredDate.toIso8601String(),
//         "status": status,
//         "basePrice": basePrice,
//         "workerProfileId": workerProfileId,
//         "invoiceId": invoiceId,
//         "clientProfileId": clientProfileId,
//         "taskTypeId": taskTypeId,
//         "paymentType": paymentType,
//         "rating": rating,
//         "review": review,
//         "accept": accept,
//         "TaskType": taskType?.toJson(),
//         "WorkerProfile": workerProfile?.toJson(),
//         "createdAtFormatted": createdAtFormatted,
//       };
// }

// class TaskType {
//   String name;
//   String id;

//   TaskType({required this.name, required this.id});

//   factory TaskType.fromJson(Map<String, dynamic> json) =>
//       TaskType(name: json["name"], id: json["id"]);

//   Map<String, dynamic> toJson() => {"name": name, "id": id};
// }

// class WorkerProfile {
//   String userName;
//   String id;

//   WorkerProfile({required this.userName, required this.id});

//   factory WorkerProfile.fromJson(Map<String, dynamic> json) =>
//       WorkerProfile(userName: json["userName"], id: json["id"]);

//   Map<String, dynamic> toJson() => {"userName": userName, "id": id};
// }

// class TaskStatistics {
//   int totalTask;
//   int totalTaskRequests;
//   int totalUnAssignedTask;
//   int totalAssignedTasks;
//   int totalConfirmedTasks;
//   int totalCompletedTasks;
//   int totalLateWork;

//   TaskStatistics({
//     required this.totalTask,
//     required this.totalTaskRequests,
//     required this.totalUnAssignedTask,
//     required this.totalAssignedTasks,
//     required this.totalConfirmedTasks,
//     required this.totalCompletedTasks,
//     required this.totalLateWork,
//   });

//   factory TaskStatistics.fromJson(Map<String, dynamic> json) => TaskStatistics(
//         totalTask: json["totalTask"],
//         totalTaskRequests: json["totalTaskRequests"],
//         totalUnAssignedTask: json["totalUnAssignedTask"],
//         totalAssignedTasks: json["totalAssignedTasks"],
//         totalConfirmedTasks: json["totalConfirmedTasks"],
//         totalCompletedTasks: json["totalCompletedTasks"],
//         totalLateWork: json["totalLateWork"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalTask": totalTask,
//         "totalTaskRequests": totalTaskRequests,
//         "totalUnAssignedTask": totalUnAssignedTask,
//         "totalAssignedTasks": totalAssignedTasks,
//         "totalConfirmedTasks": totalConfirmedTasks,
//         "totalCompletedTasks": totalCompletedTasks,
//         "totalLateWork": totalLateWork,
//       };
// }



import 'dart:convert';

Homedata homedataFromJson(String str) => Homedata.fromJson(json.decode(str));

String homedataToJson(Homedata data) => json.encode(data.toJson());

class Homedata {
  Data data;
  String message;
  bool success;

  Homedata({required this.data, required this.message, required this.success});

  factory Homedata.fromJson(Map<String, dynamic> json) => Homedata(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  TaskStatistics taskStatistics;
  List<FirstThreeTask> firstThreeTasks;
  int totalWorkers;
  AverageRating averageRating;

  Data({
    required this.taskStatistics,
    required this.firstThreeTasks,
    required this.totalWorkers,
    required this.averageRating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        taskStatistics: TaskStatistics.fromJson(json["taskStatistics"]),
        firstThreeTasks: List<FirstThreeTask>.from(
          json["firstThreeTasks"].map((x) => FirstThreeTask.fromJson(x)),
        ),
        totalWorkers: json["totalWorkers"],
        averageRating: AverageRating.fromJson(json["averageRating"]),
      );

  Map<String, dynamic> toJson() => {
        "taskStatistics": taskStatistics.toJson(),
        "firstThreeTasks": List<dynamic>.from(
          firstThreeTasks.map((x) => x.toJson()),
        ),
        "totalWorkers": totalWorkers,
        "averageRating": averageRating.toJson(),
      };
}

class AverageRating {
  Avg avg;

  AverageRating({required this.avg});

  factory AverageRating.fromJson(Map<String, dynamic> json) =>
      AverageRating(avg: Avg.fromJson(json["_avg"]));

  Map<String, dynamic> toJson() => {"_avg": avg.toJson()};
}

class Avg {
  double rating;

  Avg({required this.rating});

  factory Avg.fromJson(Map<String, dynamic> json) =>
      Avg(rating: ((json["rating"] ?? 0) as num).toDouble());

  Map<String, dynamic> toJson() => {
        "rating": double.parse(rating.toStringAsFixed(2)),
      };
}

class FirstThreeTask {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String phoneNumber;
  String email;
  String city;
  String postalCode;
  String? note; // Made nullable
  String? serviceDetailsId; // Made nullable
  String? locationDescription; // Already nullable in JSON
  String? problemDescription; // Already nullable in JSON
  DateTime preferredTime;
  DateTime preferredDate;
  String status;
  int basePrice;
  String? adminProfileId; // Made nullable
  String? workerProfileId; // Changed from dynamic to String?
  String? invoiceId; // Changed from dynamic to String?
  String? clientProfileId; // Made nullable
  String? taskTypeId;
  String paymentType;
  int rating;
  String? review; // Changed from dynamic to String?
  bool accept;
  TaskType? taskType;
  WorkerProfile? workerProfile;
  String? createdAtFormatted;

  FirstThreeTask({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.postalCode,
    this.note,
    this.serviceDetailsId,
    this.locationDescription,
    this.problemDescription,
    required this.preferredTime,
    required this.preferredDate,
    required this.status,
    required this.basePrice,
    this.adminProfileId,
    this.workerProfileId,
    this.invoiceId,
    this.clientProfileId,
    this.taskTypeId,
    required this.paymentType,
    required this.rating,
    this.review,
    required this.accept,
    this.taskType,
    this.workerProfile,
    this.createdAtFormatted,
  });

  factory FirstThreeTask.fromJson(Map<String, dynamic> json) => FirstThreeTask(
        id: json["id"],
        createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        city: json["city"],
        postalCode: json["postalCode"],
        note: json["note"],
        serviceDetailsId: json["serviceDetailsId"],
        locationDescription: json["locationDescription"],
        problemDescription: json["problemDescription"],
        preferredTime:
            DateTime.tryParse(json["preferredTime"] ?? '') ?? DateTime.now(),
        preferredDate:
            DateTime.tryParse(json["preferredDate"] ?? '') ?? DateTime.now(),
        status: json["status"],
        basePrice: json["basePrice"],
        adminProfileId: json["AdminProfileId"],
        workerProfileId: json["workerProfileId"],
        invoiceId: json["invoiceId"],
        clientProfileId: json["clientProfileId"],
        taskTypeId: json["taskTypeId"],
        paymentType: json["paymentType"],
        rating: json["rating"],
        review: json["review"],
        accept: json["accept"],
        taskType: json["TaskType"] != null
            ? TaskType.fromJson(json["TaskType"])
            : null,
        workerProfile: json["WorkerProfile"] != null
            ? WorkerProfile.fromJson(json["WorkerProfile"])
            : null,
        createdAtFormatted: json["createdAtFormatted"],
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
        "note": note,
        "serviceDetailsId": serviceDetailsId,
        "locationDescription": locationDescription,
        "problemDescription": problemDescription,
        "preferredTime": preferredTime.toIso8601String(),
        "preferredDate": preferredDate.toIso8601String(),
        "status": status,
        "basePrice": basePrice,
        "AdminProfileId": adminProfileId,
        "workerProfileId": workerProfileId,
        "invoiceId": invoiceId,
        "clientProfileId": clientProfileId,
        "taskTypeId": taskTypeId,
        "paymentType": paymentType,
        "rating": rating,
        "review": review,
        "accept": accept,
        "TaskType": taskType?.toJson(),
        "WorkerProfile": workerProfile?.toJson(),
        "createdAtFormatted": createdAtFormatted,
      };
}

class TaskType {
  String name;
  String id;

  TaskType({required this.name, required this.id});

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      TaskType(name: json["name"], id: json["id"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}

class WorkerProfile {
  String userName;
  String id;

  WorkerProfile({required this.userName, required this.id});

  factory WorkerProfile.fromJson(Map<String, dynamic> json) =>
      WorkerProfile(userName: json["userName"], id: json["id"]);

  Map<String, dynamic> toJson() => {"userName": userName, "id": id};
}

class TaskStatistics {
  int totalTask;
  int totalTaskRequests;
  int totalUnAssignedTask;
  int totalAssignedTasks;
  int totalConfirmedTasks;
  int totalCompletedTasks;
  int totalLateWork;

  TaskStatistics({
    required this.totalTask,
    required this.totalTaskRequests,
    required this.totalUnAssignedTask,
    required this.totalAssignedTasks,
    required this.totalConfirmedTasks,
    required this.totalCompletedTasks,
    required this.totalLateWork,
  });

  factory TaskStatistics.fromJson(Map<String, dynamic> json) => TaskStatistics(
        totalTask: json["totalTask"],
        totalTaskRequests: json["totalTaskRequests"],
        totalUnAssignedTask: json["totalUnAssignedTask"],
        totalAssignedTasks: json["totalAssignedTasks"],
        totalConfirmedTasks: json["totalConfirmedTasks"],
        totalCompletedTasks: json["totalCompletedTasks"],
        totalLateWork: json["totalLateWork"],
      );

  Map<String, dynamic> toJson() => {
        "totalTask": totalTask,
        "totalTaskRequests": totalTaskRequests,
        "totalUnAssignedTask": totalUnAssignedTask,
        "totalAssignedTasks": totalAssignedTasks,
        "totalConfirmedTasks": totalConfirmedTasks,
        "totalCompletedTasks": totalCompletedTasks,
        "totalLateWork": totalLateWork,
      };
}
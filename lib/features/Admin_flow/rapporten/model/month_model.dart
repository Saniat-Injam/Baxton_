// import 'dart:convert';

// Month monthFromJson(String str) => Month.fromJson(json.decode(str));

// String monthToJson(Month data) => json.encode(data.toJson());

// class Month {
//   MonthlyTurnoverReport monthlyTurnoverReport;
//   MonthlyCompletionRate monthlyCompletionRate;
//   int pendingServiceRequestsCount;
//   int totalWorkerCount;
//   ConfirmedInvoicesLineChartData confirmedInvoicesLineChartData;
//   List<TaskTypeStatistic> taskTypeStatistics;
//   List<TaskStatus> taskStatus;
//   AverageRatingAndReviews averageRatingAndReviews;

//   Month({
//     required this.monthlyTurnoverReport,
//     required this.monthlyCompletionRate,
//     required this.pendingServiceRequestsCount,
//     required this.totalWorkerCount,
//     required this.confirmedInvoicesLineChartData,
//     required this.taskTypeStatistics,
//     required this.taskStatus,
//     required this.averageRatingAndReviews,
//   });

//   factory Month.fromJson(Map<String, dynamic> json) => Month(
//     monthlyTurnoverReport: MonthlyTurnoverReport.fromJson(
//       json["monthlyTurnoverReport"],
//     ),
//     monthlyCompletionRate: MonthlyCompletionRate.fromJson(
//       json["monthlyCompletionRate"],
//     ),
//     pendingServiceRequestsCount: json["pendingServiceRequestsCount"],
//     totalWorkerCount: json["totalWorkerCount"],
//     confirmedInvoicesLineChartData: ConfirmedInvoicesLineChartData.fromJson(
//       json["confirmedInvoicesLineChartData"],
//     ),
//     taskTypeStatistics: List<TaskTypeStatistic>.from(
//       json["taskTypeStatistics"].map((x) => TaskTypeStatistic.fromJson(x)),
//     ),
//     taskStatus: List<TaskStatus>.from(
//       json["taskStatus"].map((x) => TaskStatus.fromJson(x)),
//     ),
//     averageRatingAndReviews: AverageRatingAndReviews.fromJson(
//       json["averageRatingAndReviews"],
//     ),
//   );

//   Map<String, dynamic> toJson() => {
//     "monthlyTurnoverReport": monthlyTurnoverReport.toJson(),
//     "monthlyCompletionRate": monthlyCompletionRate.toJson(),
//     "pendingServiceRequestsCount": pendingServiceRequestsCount,
//     "totalWorkerCount": totalWorkerCount,
//     "confirmedInvoicesLineChartData": confirmedInvoicesLineChartData.toJson(),
//     "taskTypeStatistics": List<dynamic>.from(
//       taskTypeStatistics.map((x) => x.toJson()),
//     ),
//     "taskStatus": List<dynamic>.from(taskStatus.map((x) => x.toJson())),
//     "averageRatingAndReviews": averageRatingAndReviews.toJson(),
//   };
// }

// class AverageRatingAndReviews {
//   double averageRating;
//   List<FirstThreeReview> firstThreeReviews;
//   int totalCount;
//   int positiveCount;
//   int positivePercentage;

//   AverageRatingAndReviews({
//     required this.averageRating,
//     required this.firstThreeReviews,
//     required this.totalCount,
//     required this.positiveCount,
//     required this.positivePercentage,
//   });

//   factory AverageRatingAndReviews.fromJson(Map<String, dynamic> json) =>
//       AverageRatingAndReviews(
//         averageRating: json["averageRating"]?.toDouble(),
//         firstThreeReviews: List<FirstThreeReview>.from(
//           json["firstThreeReviews"].map((x) => FirstThreeReview.fromJson(x)),
//         ),
//         totalCount: json["totalCount"],
//         positiveCount: json["positiveCount"],
//         positivePercentage: json["positivePercentage"],
//       );

//   Map<String, dynamic> toJson() => {
//     "averageRating": averageRating,
//     "firstThreeReviews": List<dynamic>.from(
//       firstThreeReviews.map((x) => x.toJson()),
//     ),
//     "totalCount": totalCount,
//     "positiveCount": positiveCount,
//     "positivePercentage": positivePercentage,
//   };
// }

// class FirstThreeReview {
//   String review;
//   int rating;
//   DateTime createdAt;
//   ClientProfile clientProfile;

//   FirstThreeReview({
//     required this.review,
//     required this.rating,
//     required this.createdAt,
//     required this.clientProfile,
//   });

//   factory FirstThreeReview.fromJson(Map<String, dynamic> json) =>
//       FirstThreeReview(
//         review: json["review"],
//         rating: json["rating"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         clientProfile: ClientProfile.fromJson(json["ClientProfile"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "review": review,
//     "rating": rating,
//     "createdAt": createdAt.toIso8601String(),
//     "ClientProfile": clientProfile.toJson(),
//   };
// }

// class ClientProfile {
//   String id;
//   String userId;
//   String location;
//   String userName;
//   ProfilePic profilePic;
//   User user;

//   ClientProfile({
//     required this.id,
//     required this.userId,
//     required this.location,
//     required this.userName,
//     required this.profilePic,
//     required this.user,
//   });

//   factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
//     id: json["id"],
//     userId: json["userId"],
//     location: json["location"],
//     userName: json["userName"],
//     profilePic: ProfilePic.fromJson(json["profilePic"]),
//     user: User.fromJson(json["User"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "userId": userId,
//     "location": location,
//     "userName": userName,
//     "profilePic": profilePic.toJson(),
//     "User": user.toJson(),
//   };
// }

// class ProfilePic {
//   String id;
//   DateTime createdAt;
//   String filename;
//   String originalFilename;
//   String path;
//   String url;
//   String fileType;
//   String mimeType;
//   int size;
//   dynamic serviceRequestId;
//   dynamic serviceAfterId;
//   String clientProfileId;
//   dynamic workerProfileId;
//   dynamic serviceSignatureId;
//   dynamic messageId;
//   dynamic beforePhotoId;
//   dynamic reportPhotoId;
//   dynamic adminProfileId;

//   ProfilePic({
//     required this.id,
//     required this.createdAt,
//     required this.filename,
//     required this.originalFilename,
//     required this.path,
//     required this.url,
//     required this.fileType,
//     required this.mimeType,
//     required this.size,
//     required this.serviceRequestId,
//     required this.serviceAfterId,
//     required this.clientProfileId,
//     required this.workerProfileId,
//     required this.serviceSignatureId,
//     required this.messageId,
//     required this.beforePhotoId,
//     required this.reportPhotoId,
//     required this.adminProfileId,
//   });

//   factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
//     id: json["id"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     filename: json["filename"],
//     originalFilename: json["originalFilename"],
//     path: json["path"],
//     url: json["url"],
//     fileType: json["fileType"],
//     mimeType: json["mimeType"],
//     size: json["size"],
//     serviceRequestId: json["serviceRequestId"],
//     serviceAfterId: json["serviceAfterId"],
//     clientProfileId: json["clientProfileId"],
//     workerProfileId: json["workerProfileId"],
//     serviceSignatureId: json["ServiceSignatureId"],
//     messageId: json["messageId"],
//     beforePhotoId: json["beforePhotoId"],
//     reportPhotoId: json["reportPhotoId"],
//     adminProfileId: json["adminProfileId"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "createdAt": createdAt.toIso8601String(),
//     "filename": filename,
//     "originalFilename": originalFilename,
//     "path": path,
//     "url": url,
//     "fileType": fileType,
//     "mimeType": mimeType,
//     "size": size,
//     "serviceRequestId": serviceRequestId,
//     "serviceAfterId": serviceAfterId,
//     "clientProfileId": clientProfileId,
//     "workerProfileId": workerProfileId,
//     "ServiceSignatureId": serviceSignatureId,
//     "messageId": messageId,
//     "beforePhotoId": beforePhotoId,
//     "reportPhotoId": reportPhotoId,
//     "adminProfileId": adminProfileId,
//   };
// }

// class User {
//   String name;

//   User({required this.name});

//   factory User.fromJson(Map<String, dynamic> json) => User(name: json["name"]);

//   Map<String, dynamic> toJson() => {"name": name};
// }

// class ConfirmedInvoicesLineChartData {
//   int totalRevenue;
//   List<WeeklyBreakdown> weeklyBreakdown;
//   int invoiceCount;
//   Period period;

//   ConfirmedInvoicesLineChartData({
//     required this.totalRevenue,
//     required this.weeklyBreakdown,
//     required this.invoiceCount,
//     required this.period,
//   });

//   factory ConfirmedInvoicesLineChartData.fromJson(Map<String, dynamic> json) =>
//       ConfirmedInvoicesLineChartData(
//         totalRevenue: json["totalRevenue"],
//         weeklyBreakdown: List<WeeklyBreakdown>.from(
//           json["weeklyBreakdown"].map((x) => WeeklyBreakdown.fromJson(x)),
//         ),
//         invoiceCount: json["invoiceCount"],
//         period: Period.fromJson(json["period"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "totalRevenue": totalRevenue,
//     "weeklyBreakdown": List<dynamic>.from(
//       weeklyBreakdown.map((x) => x.toJson()),
//     ),
//     "invoiceCount": invoiceCount,
//     "period": period.toJson(),
//   };
// }

// class Period {
//   DateTime from;
//   DateTime to;

//   Period({required this.from, required this.to});

//   factory Period.fromJson(Map<String, dynamic> json) => Period(
//     from: DateTime.parse(json["from"]),
//     to: DateTime.parse(json["to"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "from": from.toIso8601String(),
//     "to": to.toIso8601String(),
//   };
// }

// class WeeklyBreakdown {
//   DateTime weekStart;
//   DateTime weekEnd;
//   int totalAmount;
//   int invoiceCount;

//   WeeklyBreakdown({
//     required this.weekStart,
//     required this.weekEnd,
//     required this.totalAmount,
//     required this.invoiceCount,
//   });

//   factory WeeklyBreakdown.fromJson(Map<String, dynamic> json) =>
//       WeeklyBreakdown(
//         weekStart: DateTime.parse(json["weekStart"]),
//         weekEnd: DateTime.parse(json["weekEnd"]),
//         totalAmount: json["totalAmount"],
//         invoiceCount: json["invoiceCount"],
//       );

//   Map<String, dynamic> toJson() => {
//     "weekStart": weekStart.toIso8601String(),
//     "weekEnd": weekEnd.toIso8601String(),
//     "totalAmount": totalAmount,
//     "invoiceCount": invoiceCount,
//   };
// }

// class MonthlyCompletionRate {
//   String targetMonth;
//   int totalCompletedTasks;
//   int currentMonth;
//   int previousMonth;
//   int progressRate;

//   MonthlyCompletionRate({
//     required this.targetMonth,
//     required this.totalCompletedTasks,
//     required this.currentMonth,
//     required this.previousMonth,
//     required this.progressRate,
//   });

//   factory MonthlyCompletionRate.fromJson(Map<String, dynamic> json) =>
//       MonthlyCompletionRate(
//         targetMonth: json["targetMonth"],
//         totalCompletedTasks: json["totalCompletedTasks"],
//         currentMonth: json["currentMonth"],
//         previousMonth: json["previousMonth"],
//         progressRate: json["progressRate"],
//       );

//   Map<String, dynamic> toJson() => {
//     "targetMonth": targetMonth,
//     "totalCompletedTasks": totalCompletedTasks,
//     "currentMonth": currentMonth,
//     "previousMonth": previousMonth,
//     "progressRate": progressRate,
//   };
// }

// class MonthlyTurnoverReport {
//   String targetMonth;
//   int currentTurnover;
//   int previousTurnover;
//   int progressRate;

//   MonthlyTurnoverReport({
//     required this.targetMonth,
//     required this.currentTurnover,
//     required this.previousTurnover,
//     required this.progressRate,
//   });

//   factory MonthlyTurnoverReport.fromJson(Map<String, dynamic> json) =>
//       MonthlyTurnoverReport(
//         targetMonth: json["targetMonth"],
//         currentTurnover: json["currentTurnover"],
//         previousTurnover: json["previousTurnover"],
//         progressRate: json["progressRate"],
//       );

//   Map<String, dynamic> toJson() => {
//     "targetMonth": targetMonth,
//     "currentTurnover": currentTurnover,
//     "previousTurnover": previousTurnover,
//     "progressRate": progressRate,
//   };
// }

// class TaskStatus {
//   Count count;
//   String status;

//   TaskStatus({required this.count, required this.status});

//   factory TaskStatus.fromJson(Map<String, dynamic> json) =>
//       TaskStatus(count: Count.fromJson(json["_count"]), status: json["status"]);

//   Map<String, dynamic> toJson() => {"_count": count.toJson(), "status": status};
// }

// class Count {
//   int status;

//   Count({required this.status});

//   factory Count.fromJson(Map<String, dynamic> json) =>
//       Count(status: json["status"]);

//   Map<String, dynamic> toJson() => {"status": status};
// }

// class TaskTypeStatistic {
//   String label;
//   int count;

//   TaskTypeStatistic({required this.label, required this.count});

//   factory TaskTypeStatistic.fromJson(Map<String, dynamic> json) =>
//       TaskTypeStatistic(label: json["label"], count: json["count"]);

//   Map<String, dynamic> toJson() => {"label": label, "count": count};
// }




import 'dart:convert';

Month monthFromJson(String str) => Month.fromJson(json.decode(str));

String monthToJson(Month data) => json.encode(data.toJson());

class Month {
  MonthlyTurnoverReport monthlyTurnoverReport;
  MonthlyCompletionRate monthlyCompletionRate;
  int pendingServiceRequestsCount;
  int totalWorkerCount;
  ConfirmedInvoicesLineChartData confirmedInvoicesLineChartData;
  List<TaskTypeStatistic> taskTypeStatistics;
  List<TaskStatus> taskStatus;
  AverageRatingAndReviews averageRatingAndReviews;

  Month({
    required this.monthlyTurnoverReport,
    required this.monthlyCompletionRate,
    required this.pendingServiceRequestsCount,
    required this.totalWorkerCount,
    required this.confirmedInvoicesLineChartData,
    required this.taskTypeStatistics,
    required this.taskStatus,
    required this.averageRatingAndReviews,
  });

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    monthlyTurnoverReport: MonthlyTurnoverReport.fromJson(
      json["monthlyTurnoverReport"],
    ),
    monthlyCompletionRate: MonthlyCompletionRate.fromJson(
      json["monthlyCompletionRate"],
    ),
    pendingServiceRequestsCount: json["pendingServiceRequestsCount"],
    totalWorkerCount: json["totalWorkerCount"],
    confirmedInvoicesLineChartData: ConfirmedInvoicesLineChartData.fromJson(
      json["confirmedInvoicesLineChartData"],
    ),
    taskTypeStatistics: List<TaskTypeStatistic>.from(
      json["taskTypeStatistics"].map((x) => TaskTypeStatistic.fromJson(x)),
    ),
    taskStatus: List<TaskStatus>.from(
      json["taskStatus"].map((x) => TaskStatus.fromJson(x)),
    ),
    averageRatingAndReviews: AverageRatingAndReviews.fromJson(
      json["averageRatingAndReviews"],
    ),
  );

  Map<String, dynamic> toJson() => {
    "monthlyTurnoverReport": monthlyTurnoverReport.toJson(),
    "monthlyCompletionRate": monthlyCompletionRate.toJson(),
    "pendingServiceRequestsCount": pendingServiceRequestsCount,
    "totalWorkerCount": totalWorkerCount,
    "confirmedInvoicesLineChartData": confirmedInvoicesLineChartData.toJson(),
    "taskTypeStatistics": List<dynamic>.from(
      taskTypeStatistics.map((x) => x.toJson()),
    ),
    "taskStatus": List<dynamic>.from(taskStatus.map((x) => x.toJson())),
    "averageRatingAndReviews": averageRatingAndReviews.toJson(),
  };
}

class AverageRatingAndReviews {
  double averageRating;
  List<FirstThreeReview> firstThreeReviews;
  int totalCount;
  int positiveCount;
  int positivePercentage;

  AverageRatingAndReviews({
    required this.averageRating,
    required this.firstThreeReviews,
    required this.totalCount,
    required this.positiveCount,
    required this.positivePercentage,
  });

  factory AverageRatingAndReviews.fromJson(Map<String, dynamic> json) =>
      AverageRatingAndReviews(
        averageRating: json["averageRating"]?.toDouble(),
        firstThreeReviews: List<FirstThreeReview>.from(
          json["firstThreeReviews"].map((x) => FirstThreeReview.fromJson(x)),
        ),
        totalCount: json["totalCount"],
        positiveCount: json["positiveCount"],
        positivePercentage: json["positivePercentage"],
      );

  Map<String, dynamic> toJson() => {
    "averageRating": averageRating,
    "firstThreeReviews": List<dynamic>.from(
      firstThreeReviews.map((x) => x.toJson()),
    ),
    "totalCount": totalCount,
    "positiveCount": positiveCount,
    "positivePercentage": positivePercentage,
  };
}

class FirstThreeReview {
  String review;
  int rating;
  DateTime createdAt;
  ClientProfile clientProfile;

  FirstThreeReview({
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.clientProfile,
  });

  factory FirstThreeReview.fromJson(Map<String, dynamic> json) =>
      FirstThreeReview(
        review: json["review"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["createdAt"]),
        clientProfile: ClientProfile.fromJson(json["ClientProfile"]),
      );

  Map<String, dynamic> toJson() => {
    "review": review,
    "rating": rating,
    "createdAt": createdAt.toIso8601String(),
    "ClientProfile": clientProfile.toJson(),
  };
}

class ClientProfile {
  String id;
  String userId;
  String location;
  String userName;
  ProfilePic profilePic;
  User user;

  ClientProfile({
    required this.id,
    required this.userId,
    required this.location,
    required this.userName,
    required this.profilePic,
    required this.user,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
    id: json["id"],
    userId: json["userId"],
    location: json["location"],
    userName: json["userName"],
    profilePic: ProfilePic.fromJson(json["profilePic"]),
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "location": location,
    "userName": userName,
    "profilePic": profilePic.toJson(),
    "User": user.toJson(),
  };
}

class ProfilePic {
  String id;
  DateTime createdAt;
  String filename;
  String originalFilename;
  String path;
  String url;
  String fileType;
  String mimeType;
  int size;
  dynamic serviceRequestId;
  dynamic serviceAfterId;
  String clientProfileId;
  dynamic workerProfileId;
  dynamic serviceSignatureId;
  dynamic messageId;
  dynamic beforePhotoId;
  dynamic reportPhotoId;
  dynamic adminProfileId;

  ProfilePic({
    required this.id,
    required this.createdAt,
    required this.filename,
    required this.originalFilename,
    required this.path,
    required this.url,
    required this.fileType,
    required this.mimeType,
    required this.size,
    required this.serviceRequestId,
    required this.serviceAfterId,
    required this.clientProfileId,
    required this.workerProfileId,
    required this.serviceSignatureId,
    required this.messageId,
    required this.beforePhotoId,
    required this.reportPhotoId,
    required this.adminProfileId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    filename: json["filename"],
    originalFilename: json["originalFilename"],
    path: json["path"],
    url: json["url"],
    fileType: json["fileType"],
    mimeType: json["mimeType"],
    size: json["size"],
    serviceRequestId: json["serviceRequestId"],
    serviceAfterId: json["serviceAfterId"],
    clientProfileId: json["clientProfileId"],
    workerProfileId: json["workerProfileId"],
    serviceSignatureId: json["ServiceSignatureId"],
    messageId: json["messageId"],
    beforePhotoId: json["beforePhotoId"],
    reportPhotoId: json["reportPhotoId"],
    adminProfileId: json["adminProfileId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "filename": filename,
    "originalFilename": originalFilename,
    "path": path,
    "url": url,
    "fileType": fileType,
    "mimeType": mimeType,
    "size": size,
    "serviceRequestId": serviceRequestId,
    "serviceAfterId": serviceAfterId,
    "clientProfileId": clientProfileId,
    "workerProfileId": workerProfileId,
    "ServiceSignatureId": serviceSignatureId,
    "messageId": messageId,
    "beforePhotoId": beforePhotoId,
    "reportPhotoId": reportPhotoId,
    "adminProfileId": adminProfileId,
  };
}

class User {
  String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}

class ConfirmedInvoicesLineChartData {
  int totalRevenue;
  List<WeeklyBreakdown> weeklyBreakdown;
  int invoiceCount;
  Period period;

  ConfirmedInvoicesLineChartData({
    required this.totalRevenue,
    required this.weeklyBreakdown,
    required this.invoiceCount,
    required this.period,
  });

  factory ConfirmedInvoicesLineChartData.fromJson(Map<String, dynamic> json) =>
      ConfirmedInvoicesLineChartData(
        totalRevenue: json["totalRevenue"],
        weeklyBreakdown: List<WeeklyBreakdown>.from(
          json["weeklyBreakdown"].map((x) => WeeklyBreakdown.fromJson(x)),
        ),
        invoiceCount: json["invoiceCount"],
        period: Period.fromJson(json["period"]),
      );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "weeklyBreakdown": List<dynamic>.from(
      weeklyBreakdown.map((x) => x.toJson()),
    ),
    "invoiceCount": invoiceCount,
    "period": period.toJson(),
  };
}

class Period {
  DateTime from;
  DateTime to;

  Period({required this.from, required this.to});

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
  };
}

class WeeklyBreakdown {
  DateTime weekStart;
  DateTime weekEnd;
  int totalAmount;
  int invoiceCount;

  WeeklyBreakdown({
    required this.weekStart,
    required this.weekEnd,
    required this.totalAmount,
    required this.invoiceCount,
  });

  factory WeeklyBreakdown.fromJson(Map<String, dynamic> json) =>
      WeeklyBreakdown(
        weekStart: DateTime.parse(json["weekStart"]),
        weekEnd: DateTime.parse(json["weekEnd"]),
        totalAmount: json["totalAmount"],
        invoiceCount: json["invoiceCount"],
      );

  Map<String, dynamic> toJson() => {
    "weekStart": weekStart.toIso8601String(),
    "weekEnd": weekEnd.toIso8601String(),
    "totalAmount": totalAmount,
    "invoiceCount": invoiceCount,
  };
}

class MonthlyCompletionRate {
  String targetMonth;
  int totalCompletedTasks;
  int currentMonth;
  int previousMonth;
  int progressRate;

  MonthlyCompletionRate({
    required this.targetMonth,
    required this.totalCompletedTasks,
    required this.currentMonth,
    required this.previousMonth,
    required this.progressRate,
  });

  factory MonthlyCompletionRate.fromJson(Map<String, dynamic> json) =>
      MonthlyCompletionRate(
        targetMonth: json["targetMonth"],
        totalCompletedTasks: json["totalCompletedTasks"],
        currentMonth: json["currentMonth"],
        previousMonth: json["previousMonth"],
        progressRate: json["progressRate"],
      );

  Map<String, dynamic> toJson() => {
    "targetMonth": targetMonth,
    "totalCompletedTasks": totalCompletedTasks,
    "currentMonth": currentMonth,
    "previousMonth": previousMonth,
    "progressRate": progressRate,
  };
}

class MonthlyTurnoverReport {
  String targetMonth;
  int currentTurnover;
  int previousTurnover;
  int progressRate;

  MonthlyTurnoverReport({
    required this.targetMonth,
    required this.currentTurnover,
    required this.previousTurnover,
    required this.progressRate,
  });

  factory MonthlyTurnoverReport.fromJson(Map<String, dynamic> json) =>
      MonthlyTurnoverReport(
        targetMonth: json["targetMonth"],
        currentTurnover: json["currentTurnover"],
        previousTurnover: json["previousTurnover"],
        progressRate: json["progressRate"],
      );

  Map<String, dynamic> toJson() => {
    "targetMonth": targetMonth,
    "currentTurnover": currentTurnover,
    "previousTurnover": previousTurnover,
    "progressRate": progressRate,
  };
}

class TaskStatus {
  Count count;
  String status;

  TaskStatus({required this.count, required this.status});

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      TaskStatus(count: Count.fromJson(json["_count"]), status: json["status"]);

  Map<String, dynamic> toJson() => {"_count": count.toJson(), "status": status};
}

class Count {
  int status;

  Count({required this.status});

  factory Count.fromJson(Map<String, dynamic> json) =>
      Count(status: json["status"]);

  Map<String, dynamic> toJson() => {"status": status};
}

class TaskTypeStatistic {
  String label;
  int count;

  TaskTypeStatistic({required this.label, required this.count});

  factory TaskTypeStatistic.fromJson(Map<String, dynamic> json) =>
      TaskTypeStatistic(label: json["label"], count: json["count"]);

  Map<String, dynamic> toJson() => {"label": label, "count": count};
}
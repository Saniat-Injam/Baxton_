import 'dart:convert';

Getservicerequest getservicerequestFromJson(String str) => Getservicerequest.fromJson(json.decode(str));

String getservicerequestToJson(Getservicerequest data) => json.encode(data.toJson());

class Getservicerequest {
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
    dynamic workerProfileId;
    dynamic invoiceId;
    String clientProfileId;
    String taskTypeId;
    String paymentType;
    int rating;
    dynamic review;
    bool accept;
    TaskType taskType;
    ReqPhoto? reqPhoto;

    Getservicerequest({
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
        required this.taskType,
        this.reqPhoto,
    });

    factory Getservicerequest.fromJson(Map<String, dynamic> json) => Getservicerequest(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        city: json["city"],
        postalCode: json["postalCode"],
        locationDescription: json["locationDescription"],
        problemDescription: json["problemDescription"],
        preferredTime: DateTime.parse(json["preferredTime"]),
        preferredDate: DateTime.parse(json["preferredDate"]),
        status: json["status"],
        basePrice: json["basePrice"],
        workerProfileId: json["workerProfileId"],
        invoiceId: json["invoiceId"],
        clientProfileId: json["clientProfileId"],
        taskTypeId: json["taskTypeId"],
        paymentType: json["paymentType"],
        rating: json["rating"],
        review: json["review"],
        accept: json["accept"],
        taskType: TaskType.fromJson(json["TaskType"]),
        reqPhoto: json["reqPhoto"] is Map<String, dynamic> ? ReqPhoto.fromJson(json["reqPhoto"]) : null,
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
        "TaskType": taskType.toJson(),
        "reqPhoto": reqPhoto?.toJson(),
    };
}

class TaskType {
    String name;

    TaskType({
        required this.name,
    });

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class ReqPhoto {
    String url;

    ReqPhoto({
        required this.url,
    });

    factory ReqPhoto.fromJson(Map<String, dynamic> json) => ReqPhoto(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
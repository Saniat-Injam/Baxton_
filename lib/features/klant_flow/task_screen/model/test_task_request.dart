// To parse this JSON data, do
//
//     final taskrequested = taskrequestedFromJson(jsonString);

import 'dart:convert';

Taskrequested taskrequestedFromJson(String str) => Taskrequested.fromJson(json.decode(str));

String taskrequestedToJson(Taskrequested data) => json.encode(data.toJson());

class Taskrequested {
    List<Datum> data;
    String message;
    bool success;

    Taskrequested({
        required this.data,
        required this.message,
        required this.success,
    });

    factory Taskrequested.fromJson(Map<String, dynamic> json) => Taskrequested(
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
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    String name;
    String phoneNumber;
    String email;
    String city;
    String postalCode;
    dynamic note;
    dynamic serviceDetailsId;
    String locationDescription;
    String problemDescription;
    DateTime preferredTime;
    DateTime preferredDate;
    String status;
    int basePrice;
    dynamic adminProfileId;
    dynamic workerProfileId;
    dynamic invoiceId;
    String clientProfileId;
    String taskTypeId;
    String paymentType;
    int rating;
    dynamic review;
    bool accept;

    Datum({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.name,
        required this.phoneNumber,
        required this.email,
        required this.city,
        required this.postalCode,
        required this.note,
        required this.serviceDetailsId,
        required this.locationDescription,
        required this.problemDescription,
        required this.preferredTime,
        required this.preferredDate,
        required this.status,
        required this.basePrice,
        required this.adminProfileId,
        required this.workerProfileId,
        required this.invoiceId,
        required this.clientProfileId,
        required this.taskTypeId,
        required this.paymentType,
        required this.rating,
        required this.review,
        required this.accept,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        city: json["city"],
        postalCode: json["postalCode"],
        note: json["note"],
        serviceDetailsId: json["serviceDetailsId"],
        locationDescription: json["locationDescription"],
        problemDescription: json["problemDescription"],
        preferredTime: DateTime.parse(json["preferredTime"]),
        preferredDate: DateTime.parse(json["preferredDate"]),
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
    };
}

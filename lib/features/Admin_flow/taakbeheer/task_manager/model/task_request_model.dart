// To parse this JSON data, do
//
//     final taskrequest = taskrequestFromJson(jsonString);

import 'dart:convert';

Taskrequest taskrequestFromJson(String str) => Taskrequest.fromJson(json.decode(str));

String taskrequestToJson(Taskrequest data) => json.encode(data.toJson());

class Taskrequest {
    List<Datum> data;
    String message;
    bool success;

    Taskrequest({
        required this.data,
        required this.message,
        required this.success,
    });

    factory Taskrequest.fromJson(Map<String, dynamic> json) => Taskrequest(
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
    String name;
    DateTime createdAt;
    String locationDescription;
    String city;
    String status;
    TaskType taskType;
    ReqPhoto reqPhoto;
    ClientProfile clientProfile;

    Datum({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.locationDescription,
        required this.city,
        required this.status,
        required this.taskType,
        required this.reqPhoto,
        required this.clientProfile,
    });

   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
    locationDescription: json["locationDescription"],
    city: json["city"],
    status: json["status"],
    taskType: TaskType.fromJson(json["TaskType"]),
    reqPhoto: ReqPhoto.fromJson(json["reqPhoto"]),
    clientProfile: ClientProfile.fromJson(json["ClientProfile"]),
);

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "locationDescription": locationDescription,
        "city": city,
        "status": status,
        "TaskType": taskType.toJson(),
        "reqPhoto": reqPhoto.toJson(),
        "ClientProfile": clientProfile.toJson(),
    };
}

class ClientProfile {
    String id;
    String userId;
    String location;
    String userName;

    ClientProfile({
        required this.id,
        required this.userId,
        required this.location,
        required this.userName,
    });

    factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
        id: json["id"],
        userId: json["userId"],
        location: json["location"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "location": location,
        "userName": userName,
    };
}

class ReqPhoto {
    String id;
    DateTime createdAt;
    String filename;
    String originalFilename;
    String path;
    String url;
    String fileType;
    String mimeType;
    int size;
    String serviceRequestId;
    dynamic serviceAfterId;
    dynamic clientProfileId;
    dynamic workerProfileId;
    dynamic serviceSignatureId;
    dynamic messageId;
    dynamic beforePhotoId;
    dynamic reportPhotoId;
    dynamic adminProfileId;

    ReqPhoto({
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

    factory ReqPhoto.fromJson(Map<String, dynamic> json) => ReqPhoto(
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

class TaskType {
    String id;
    String name;

    TaskType({
        required this.id,
        required this.name,
    });

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

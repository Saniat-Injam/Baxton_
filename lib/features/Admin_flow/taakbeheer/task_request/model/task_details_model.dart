import 'dart:convert';
Taskdetails taskdetailsFromJson(String str) => Taskdetails.fromJson(json.decode(str));
String taskdetailsToJson(Taskdetails data) => json.encode(data.toJson());

class Taskdetails {
    Data data;
    String message;
    bool success;

    Taskdetails({
        required this.data,
        required this.message,
        required this.success,
    });

    factory Taskdetails.fromJson(Map<String, dynamic> json) => Taskdetails(
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
    String? workerProfileId;
    String? invoiceId;
    String clientProfileId;
    String taskTypeId;
    String paymentType;
    int rating;
    String? review;
    bool accept;
    List<Task> tasks;
    List<ReqPhoto> reportPhoto;
    List<ReqPhoto> afterPhoto;
    List<ReqPhoto> beforePhoto;
    ClientProfile clientProfile;
    WorkerProfile? workerProfile;
    TaskType taskType;
    String? signature;
    ReqPhoto? reqPhoto;
    String? reviews;

    Data({
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
        this.workerProfileId,
        this.invoiceId,
        required this.clientProfileId,
        required this.taskTypeId,
        required this.paymentType,
        required this.rating,
        this.review,
        required this.accept,
        required this.tasks,
        required this.reportPhoto,
        required this.afterPhoto,
        required this.beforePhoto,
        required this.clientProfile,
        this.workerProfile,
        required this.taskType,
        this.signature,
        this.reqPhoto,
        this.reviews,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        reportPhoto: List<ReqPhoto>.from(json["reportPhoto"].map((x) => ReqPhoto.fromJson(x))),
        afterPhoto: List<ReqPhoto>.from(json["afterPhoto"].map((x) => ReqPhoto.fromJson(x))),
        beforePhoto: List<ReqPhoto>.from(json["beforePhoto"].map((x) => ReqPhoto.fromJson(x))),
        clientProfile: ClientProfile.fromJson(json["ClientProfile"]),
        workerProfile: json["WorkerProfile"] != null ? WorkerProfile.fromJson(json["WorkerProfile"]) : null,
        taskType: TaskType.fromJson(json["TaskType"]),
        signature: json["signature"],
        reqPhoto: json["reqPhoto"] != null ? ReqPhoto.fromJson(json["reqPhoto"]) : null,
        reviews: json["Reviews"],
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
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
        "reportPhoto": List<dynamic>.from(reportPhoto.map((x) => x.toJson())),
        "afterPhoto": List<dynamic>.from(afterPhoto.map((x) => x.toJson())),
        "beforePhoto": List<dynamic>.from(beforePhoto.map((x) => x.toJson())),
        "ClientProfile": clientProfile.toJson(),
        "WorkerProfile": workerProfile?.toJson(),
        "TaskType": taskType.toJson(),
        "signature": signature,
        "reqPhoto": reqPhoto?.toJson(),
        "Reviews": reviews,
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

class WorkerProfile {
    String? id;
    String? name;
    String? expertise;
    String? imageUrl;

    WorkerProfile({
        this.id,
        this.name,
        this.expertise,
        this.imageUrl,
    });

    factory WorkerProfile.fromJson(Map<String, dynamic> json) => WorkerProfile(
        id: json["id"],
        name: json["name"],
        expertise: json["expertise"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "expertise": expertise,
        "imageUrl": imageUrl,
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
    String? serviceAfterId;
    String? clientProfileId;
    String? workerProfileId;
    String? serviceSignatureId;
    String? messageId;
    String? beforePhotoId;
    String? reportPhotoId;
    String? adminProfileId;

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
        this.serviceAfterId,
        this.clientProfileId,
        this.workerProfileId,
        this.serviceSignatureId,
        this.messageId,
        this.beforePhotoId,
        this.reportPhotoId,
        this.adminProfileId,
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

class Task {
    String id;
    String name;
    int price;
    String serviceRequestId;
    String clientId;
    dynamic workerId;
    bool done;
    DateTime createdAt;
    DateTime updatedAt;

    Task({
        required this.id,
        required this.name,
        required this.price,
        required this.serviceRequestId,
        required this.clientId,
        required this.workerId,
        required this.done,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        serviceRequestId: json["serviceRequestId"],
        clientId: json["clientId"],
        workerId: json["workerId"],
        done: json["done"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "serviceRequestId": serviceRequestId,
        "clientId": clientId,
        "workerId": workerId,
        "done": done,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
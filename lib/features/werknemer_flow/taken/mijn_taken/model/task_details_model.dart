import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/admin_profile_model.dart';

class TaskDetailsModel {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? city;
  final String? postalCode;
  final String? locationDescription;
  final String? problemDescription;
  final String? preferredTime;
  final String? preferredDate;
  final String? status;
  final double? basePrice;
  final String? paymentType;
  final ClientProfile? clientProfile;
  final WorkerProfile? workerProfile;
  final AdminProfile? adminProfile;
  final String? taskTypeName;
  final String? reqPhotoUrl;
  final String? note;
  final String? serviceDetailsId;
  final String? adminProfileId;
  final String? invoiceId;
  final double? rating;
  final String? review;
  final bool? accept;
  final List<TaskItem>? tasks;
  final List<PhotoItem>? afterPhoto;
  final List<PhotoItem>? beforePhoto;
  final Invoice? invoice;
  final List<ServiceDetailsItem>? serviceDetails;
  final PhotoItem? signature;
  final ReviewItem? reviews;

  TaskDetailsModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phoneNumber,
    this.email,
    this.city,
    this.postalCode,
    this.locationDescription,
    this.problemDescription,
    this.preferredTime,
    this.preferredDate,
    this.status,
    this.basePrice,
    this.paymentType,
    this.clientProfile,
    this.adminProfile,
    this.workerProfile,
    this.taskTypeName,
    this.reqPhotoUrl,
    this.note,
    this.serviceDetailsId,
    this.adminProfileId,
    this.invoiceId,
    this.rating,
    this.review,
    this.accept,
    this.tasks,
    this.afterPhoto,
    this.beforePhoto,
    this.invoice,
    this.serviceDetails,
    this.signature,
    this.reviews,
  });

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailsModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      city: json['city'],
      postalCode: json['postalCode'],
      locationDescription: json['locationDescription'],
      problemDescription: json['problemDescription'],
      preferredTime: json['preferredTime'],
      preferredDate: json['preferredDate'],
      status: json['status'],
      basePrice:
          (json['basePrice'] != null)
              ? (json['basePrice'] is int
                  ? (json['basePrice'] as int).toDouble()
                  : json['basePrice'] as double)
              : null,
      paymentType: json['paymentType'],
      clientProfile:
          json['ClientProfile'] != null
              ? ClientProfile.fromJson(json['ClientProfile'])
              : null,
      adminProfile:
          json['AdminProfile'] != null
              ? AdminProfile.fromJson(json['AdminProfile'])
              : null,
      workerProfile:
          json['WorkerProfile'] != null
              ? WorkerProfile.fromJson(json['WorkerProfile'])
              : null,
      taskTypeName: json['TaskType'] != null ? json['TaskType']['name'] : null,
      reqPhotoUrl: json['reqPhoto'] != null ? json['reqPhoto']['url'] : null,
      note: json['note'],
      serviceDetailsId: json['serviceDetailsId'],
      adminProfileId: json['AdminProfileId'],
      invoiceId: json['invoiceId'],
      rating:
          json['rating'] != null
              ? (json['rating'] is int
                  ? (json['rating'] as int).toDouble()
                  : json['rating'] as double)
              : null,
      review: json['review'],
      accept: json['accept'],
      tasks:
          json['tasks'] != null
              ? List<Map<String, dynamic>>.from(
                json['tasks'],
              ).map((e) => TaskItem.fromJson(e)).toList()
              : null,
      afterPhoto:
          json['afterPhoto'] != null
              ? List<Map<String, dynamic>>.from(
                json['afterPhoto'],
              ).map((e) => PhotoItem.fromJson(e)).toList()
              : null,
      beforePhoto:
          json['beforePhoto'] != null
              ? List<Map<String, dynamic>>.from(
                json['beforePhoto'],
              ).map((e) => PhotoItem.fromJson(e)).toList()
              : null,
      invoice:
          json['Invoice'] != null ? Invoice.fromJson(json['Invoice']) : null,
      serviceDetails:
          json['serviceDetails'] != null
              ? List<Map<String, dynamic>>.from(
                json['serviceDetails'],
              ).map((e) => ServiceDetailsItem.fromJson(e)).toList()
              : null,
      signature:
          json['signature'] != null
              ? PhotoItem.fromJson(json['signature'])
              : null,
      reviews:
          json['Reviews'] != null ? ReviewItem.fromJson(json['Reviews']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'postalCode': postalCode,
      'locationDescription': locationDescription,
      'problemDescription': problemDescription,
      'preferredTime': preferredTime,
      'preferredDate': preferredDate,
      'status': status,
      'basePrice': basePrice,
      'paymentType': paymentType,
      'ClientProfile': clientProfile?.toJson(),
      'AdminProfile': adminProfile?.toJson(),
      'WorkerProfile': workerProfile?.toJson(),
      'TaskType': {'name': taskTypeName},
      'reqPhoto': {'url': reqPhotoUrl},
      'note': note,
      'serviceDetailsId': serviceDetailsId,
      'AdminProfileId': adminProfileId,
      'invoiceId': invoiceId,
      'rating': rating,
      'review': review,
      'accept': accept,
      'tasks': tasks?.map((e) => e.toJson()).toList(),
      'afterPhoto': afterPhoto?.map((e) => e.toJson()).toList(),
      'beforePhoto': beforePhoto?.map((e) => e.toJson()).toList(),
      'Invoice': invoice?.toJson(),
      'serviceDetails': serviceDetails?.map((e) => e.toJson()).toList(),
      'signature': signature?.toJson(),
      'Reviews': reviews?.toJson(),
    };
  }
}

class TaskItem {
  final String? id;
  final String? name;
  final double? price;
  final String? serviceRequestId;
  final String? clientId;
  final String? workerId;
  final bool? done;
  final String? createdAt;
  final String? updatedAt;

  TaskItem({
    this.id,
    this.name,
    this.price,
    this.serviceRequestId,
    this.clientId,
    this.workerId,
    this.done,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'],
      name: json['name'],
      price:
          json['price'] != null
              ? (json['price'] is int
                  ? (json['price'] as int).toDouble()
                  : json['price'] as double)
              : null,
      serviceRequestId: json['serviceRequestId'],
      clientId: json['clientId'],
      workerId: json['workerId'],
      done: json['done'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'serviceRequestId': serviceRequestId,
      'clientId': clientId,
      'workerId': workerId,
      'done': done,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class PhotoItem {
  final String? id;
  final String? createdAt;
  final String? filename;
  final String? originalFilename;
  final String? path;
  final String? url;
  final String? fileType;
  final String? mimeType;
  final int? size;
  final String? caption;

  PhotoItem({
    this.id,
    this.createdAt,
    this.filename,
    this.originalFilename,
    this.path,
    this.url,
    this.fileType,
    this.mimeType,
    this.size,
    this.caption,
  });

  factory PhotoItem.fromJson(Map<String, dynamic> json) {
    return PhotoItem(
      id: json['id'],
      createdAt: json['createdAt'],
      filename: json['filename'],
      originalFilename: json['originalFilename'],
      path: json['path'],
      url: json['url'],
      fileType: json['fileType'],
      mimeType: json['mimeType'],
      size: json['size'],
      caption: json['caption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'filename': filename,
      'originalFilename': originalFilename,
      'path': path,
      'url': url,
      'fileType': fileType,
      'mimeType': mimeType,
      'size': size,
      'caption': caption,
    };
  }
}

class Invoice {
  final String? id;
  final String? invoiceNumber;
  final String? clientProfileId;
  final String? workerProfileId;
  final String? bankInfoId;
  final String? dateIssued;
  final String? duaDate;
  final String? invoiceStatus;
  final double? totalAmount;
  final String? companyId;

  Invoice({
    this.id,
    this.invoiceNumber,
    this.clientProfileId,
    this.workerProfileId,
    this.bankInfoId,
    this.dateIssued,
    this.duaDate,
    this.invoiceStatus,
    this.totalAmount,
    this.companyId,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoiceNumber'],
      clientProfileId: json['clientProfileId'],
      workerProfileId: json['workerProfileId'],
      bankInfoId: json['bankInfoId'],
      dateIssued: json['dateIssued'],
      duaDate: json['duaDate'],
      invoiceStatus: json['invoiceStatus'],
      totalAmount:
          json['totalAmount'] != null
              ? (json['totalAmount'] is int
                  ? (json['totalAmount'] as int).toDouble()
                  : json['totalAmount'] as double)
              : null,
      companyId: json['companyId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'clientProfileId': clientProfileId,
      'workerProfileId': workerProfileId,
      'bankInfoId': bankInfoId,
      'dateIssued': dateIssued,
      'duaDate': duaDate,
      'invoiceStatus': invoiceStatus,
      'totalAmount': totalAmount,
      'companyId': companyId,
    };
  }
}

class ServiceDetailsItem {
  final String? id;
  final String? serviceRequestId;
  final String? serviceName;
  final double? servicePrice;

  ServiceDetailsItem({
    this.id,
    this.serviceRequestId,
    this.serviceName,
    this.servicePrice,
  });

  factory ServiceDetailsItem.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsItem(
      id: json['id'],
      serviceRequestId: json['serviceRequestId'],
      serviceName: json['serviceName'],
      servicePrice:
          json['servicePrice'] != null
              ? (json['servicePrice'] is int
                  ? (json['servicePrice'] as int).toDouble()
                  : json['servicePrice'] as double)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceRequestId': serviceRequestId,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
    };
  }
}

class ClientProfile {
  final String? id;
  final String? userId;
  final String? location;
  final String? userName;

  ClientProfile({this.id, this.userId, this.location, this.userName});

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      id: json['id'],
      userId: json['userId'],
      location: json['location'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'location': location,
      'userName': userName,
    };
  }
}

class WorkerProfile {
  final String? id;
  final String? userId;
  final String? userName;
  final String? workerId;
  final String? location;
  final String? workerSpecialistId;
  final String? isActive;
  final ProfilePic? profilePic;

  WorkerProfile({
    this.id,
    this.userId,
    this.userName,
    this.workerId,
    this.location,
    this.workerSpecialistId,
    this.isActive,
    this.profilePic,
  });

  factory WorkerProfile.fromJson(Map<String, dynamic> json) {
    return WorkerProfile(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      workerId: json['workerId'],
      location: json['location'],
      workerSpecialistId: json['workerSpecialistId'],
      isActive: json['isActive'],
      profilePic:
          json['profilePic'] != null
              ? ProfilePic.fromJson(json['profilePic'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'workerId': workerId,
      'location': location,
      'workerSpecialistId': workerSpecialistId,
      'isActive': isActive,
      'profilePic': profilePic?.toJson(),
    };
  }
}

class ProfilePic {
  final String? id;
  final String? url;

  ProfilePic({this.id, this.url});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }
}

class ReviewItem {
  final String? id;
  final double? rating;
  final String? review;
  final String? createdAt;
  final String? updatedAt;
  final String? serviceRequestId;
  final String? clientProfileId;
  final String? workerProfileId;

  ReviewItem({
    this.id,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.serviceRequestId,
    this.clientProfileId,
    this.workerProfileId,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      id: json['id'],
      rating:
          json['rating'] != null
              ? (json['rating'] is int
                  ? (json['rating'] as int).toDouble()
                  : json['rating'] as double)
              : null,
      review: json['review'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      serviceRequestId: json['serviceRequestId'],
      clientProfileId: json['clientProfileId'],
      workerProfileId: json['workerProfileId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'review': review,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'serviceRequestId': serviceRequestId,
      'clientProfileId': clientProfileId,
      'workerProfileId': workerProfileId,
    };
  }
}

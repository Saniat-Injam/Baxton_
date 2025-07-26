import 'package:flutter/rendering.dart';

class ServiceRequest {
  final String id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? city;
  final String? postalCode;
  final String? note;
  final String? serviceDetailsId;
  final String? locationDescription;
  final String? problemDescription;
  final String? preferredTime;
  final String? preferredDate;
  final String status;
  final double basePrice;
  final String? adminProfileId;
  final String? workerProfileId;
  final String? invoiceId;
  final String? clientProfileId;
  final String? taskTypeId;
  final String? paymentType;
  final int rating;
  final String? review;
  final bool accept;

  ServiceRequest({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phoneNumber,
    this.email,
    this.city,
    this.postalCode,
    this.note,
    this.serviceDetailsId,
    this.locationDescription,
    this.problemDescription,
    this.preferredTime,
    this.preferredDate,
    required this.status,
    required this.basePrice,
    this.adminProfileId,
    this.workerProfileId,
    this.invoiceId,
    this.clientProfileId,
    this.taskTypeId,
    this.paymentType,
    required this.rating,
    this.review,
    required this.accept,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    // Skip empty objects
    if (json.isEmpty) {
      throw FormatException('Empty JSON object for ServiceRequest');
    }

    try {
      return ServiceRequest(
        id: json['id']?.toString() ?? '',
        createdAt: json['createdAt']?.toString(),
        updatedAt: json['updatedAt']?.toString(),
        name: json['name']?.toString(),
        phoneNumber: json['phoneNumber']?.toString(),
        email: json['email']?.toString(),
        city: json['city']?.toString(),
        postalCode: json['postalCode']?.toString(),
        note: json['note']?.toString(),
        serviceDetailsId: json['serviceDetailsId']?.toString(),
        locationDescription: json['locationDescription']?.toString(),
        problemDescription: json['problemDescription']?.toString(),
        preferredTime: json['preferredTime']?.toString(),
        preferredDate: json['preferredDate']?.toString(),
        status: json['status']?.toString() ?? '',
        basePrice: (json['basePrice'] ?? 0).toDouble(),
        adminProfileId: json['AdminProfileId']?.toString() ?? json['adminProfileId']?.toString(),
        workerProfileId: json['workerProfileId']?.toString(),
        invoiceId: json['invoiceId']?.toString(),
        clientProfileId: json['clientProfileId']?.toString(),
        taskTypeId: json['taskTypeId']?.toString(),
        paymentType: json['paymentType']?.toString(),
        rating: json['rating'] ?? 0,
        review: json['review']?.toString(),
        accept: json['accept'] ?? false,
      );
    } catch (e, stackTrace) {
      debugPrint('Error parsing ServiceRequest: $e');
      debugPrint('JSON: $json');
      debugPrint('Stack trace: $stackTrace');
      
      rethrow;
    }
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
      'note': note,
      'serviceDetailsId': serviceDetailsId,
      'locationDescription': locationDescription,
      'problemDescription': problemDescription,
      'preferredTime': preferredTime,
      'preferredDate': preferredDate,
      'status': status,
      'basePrice': basePrice,
      'AdminProfileId': adminProfileId,
      'workerProfileId': workerProfileId,
      'invoiceId': invoiceId,
      'clientProfileId': clientProfileId,
      'taskTypeId': taskTypeId,
      'paymentType': paymentType,
      'rating': rating,
      'review': review,
      'accept': accept,
    };
  }
}
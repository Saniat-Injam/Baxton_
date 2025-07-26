// To parse this JSON data, do
//
//     final getclientinvoice = getclientinvoiceFromJson(jsonString);

import 'dart:convert';

Getclientinvoice getclientinvoiceFromJson(String str) => Getclientinvoice.fromJson(json.decode(str));

String getclientinvoiceToJson(Getclientinvoice data) => json.encode(data.toJson());

class Getclientinvoice {
    Data data;
    String message;
    bool success;

    Getclientinvoice({
        required this.data,
        required this.message,
        required this.success,
    });

    factory Getclientinvoice.fromJson(Map<String, dynamic> json) => Getclientinvoice(
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
    ClientInfo clientInfo;
    WorkerInfo workerInfo;
    CompanyInfo companyInfo;
    List<ServiceDetail> serviceDetail;
    ServiceRequestDetails serviceRequestDetails;
    BankInfo bankInfo;
    String invoiceNumber;

    Data({
        required this.clientInfo,
        required this.workerInfo,
        required this.companyInfo,
        required this.serviceDetail,
        required this.serviceRequestDetails,
        required this.bankInfo,
        required this.invoiceNumber,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientInfo: ClientInfo.fromJson(json["clientInfo"]),
        workerInfo: WorkerInfo.fromJson(json["workerInfo"]),
        companyInfo: CompanyInfo.fromJson(json["companyInfo"]),
        serviceDetail: List<ServiceDetail>.from(json["serviceDetail"].map((x) => ServiceDetail.fromJson(x))),
        serviceRequestDetails: ServiceRequestDetails.fromJson(json["serviceRequestDetails"]),
        bankInfo: BankInfo.fromJson(json["bankInfo"]),
        invoiceNumber: json["invoiceNumber"],
    );

    Map<String, dynamic> toJson() => {
        "clientInfo": clientInfo.toJson(),
        "workerInfo": workerInfo.toJson(),
        "companyInfo": companyInfo.toJson(),
        "serviceDetail": List<dynamic>.from(serviceDetail.map((x) => x.toJson())),
        "serviceRequestDetails": serviceRequestDetails.toJson(),
        "bankInfo": bankInfo.toJson(),
        "invoiceNumber": invoiceNumber,
    };
}

class BankInfo {
    String bankName;
    String iban;
    String bicOrSwift;

    BankInfo({
        required this.bankName,
        required this.iban,
        required this.bicOrSwift,
    });

    factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        bankName: json["bankName"],
        iban: json["IBAN"],
        bicOrSwift: json["BIC_or_SWIFT"],
    );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "IBAN": iban,
        "BIC_or_SWIFT": bicOrSwift,
    };
}

class ClientInfo {
    String name;
    String email;
    String phone;
    String location;
    String postalCode;

    ClientInfo({
        required this.name,
        required this.email,
        required this.phone,
        required this.location,
        required this.postalCode,
    });

    factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: json["location"],
        postalCode: json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
        "postalCode": postalCode,
    };
}

class CompanyInfo {
    String id;
    String city;
    String state;
    String phone;
    String email;
    String name;

    CompanyInfo({
        required this.id,
        required this.city,
        required this.state,
        required this.phone,
        required this.email,
        required this.name,
    });

    factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        id: json["id"],
        city: json["city"],
        state: json["state"],
        phone: json["phone"],
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state": state,
        "phone": phone,
        "email": email,
        "name": name,
    };
}

class ServiceDetail {
    String taskName;
    int taskPrice;

    ServiceDetail({
        required this.taskName,
        required this.taskPrice,
    });

    factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        taskName: json["taskName"],
        taskPrice: json["taskPrice"],
    );

    Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskPrice": taskPrice,
    };
}

class ServiceRequestDetails {
    String locationDescription;
    String paymentType;
    String postalCode;
    DateTime preferredDate;
    DateTime preferredTime;
    String problemDescription;
    String phoneNumber;
    DateTime updatedAt;
    DateTime finishedAt;

    ServiceRequestDetails({
        required this.locationDescription,
        required this.paymentType,
        required this.postalCode,
        required this.preferredDate,
        required this.preferredTime,
        required this.problemDescription,
        required this.phoneNumber,
        required this.updatedAt,
        required this.finishedAt,
    });

    factory ServiceRequestDetails.fromJson(Map<String, dynamic> json) => ServiceRequestDetails(
        locationDescription: json["locationDescription"],
        paymentType: json["paymentType"],
        postalCode: json["postalCode"],
        preferredDate: DateTime.parse(json["preferredDate"]),
        preferredTime: DateTime.parse(json["preferredTime"]),
        problemDescription: json["problemDescription"],
        phoneNumber: json["phoneNumber"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        finishedAt: DateTime.parse(json["finishedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "locationDescription": locationDescription,
        "paymentType": paymentType,
        "postalCode": postalCode,
        "preferredDate": preferredDate.toIso8601String(),
        "preferredTime": preferredTime.toIso8601String(),
        "problemDescription": problemDescription,
        "phoneNumber": phoneNumber,
        "updatedAt": updatedAt.toIso8601String(),
        "finishedAt": finishedAt.toIso8601String(),
    };
}

class WorkerInfo {
    String name;
    String email;
    String phone;
    String specialist;

    WorkerInfo({
        required this.name,
        required this.email,
        required this.phone,
        required this.specialist,
    });

    factory WorkerInfo.fromJson(Map<String, dynamic> json) => WorkerInfo(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        specialist: json["specialist"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "specialist": specialist,
    };
}

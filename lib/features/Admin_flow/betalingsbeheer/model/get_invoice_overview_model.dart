// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, camel_case_types

class getinvoiceoverview {
  Data? data;
  String? message;
  bool? success;

  getinvoiceoverview({this.data, this.message, this.success});

  getinvoiceoverview.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  TotalInvoices? totalInvoices;
  List<Invoices>? invoices;

  Data({this.totalInvoices, this.invoices});

  Data.fromJson(Map<String, dynamic> json) {
    totalInvoices = json['totalInvoices'] != null
        ? new TotalInvoices.fromJson(json['totalInvoices'])
        : null;
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalInvoices != null) {
      data['totalInvoices'] = this.totalInvoices!.toJson();
    }
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalInvoices {
  int? totalAmountReceived;
  int? pendingPayments;
  int? latePayments;
  int? confirmedInvoicesCount;

  TotalInvoices(
      {this.totalAmountReceived,
      this.pendingPayments,
      this.latePayments,
      this.confirmedInvoicesCount});

  TotalInvoices.fromJson(Map<String, dynamic> json) {
    totalAmountReceived = json['totalAmountReceived'];
    pendingPayments = json['pendingPayments'];
    latePayments = json['latePayments'];
    confirmedInvoicesCount = json['confirmedInvoicesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmountReceived'] = this.totalAmountReceived;
    data['pendingPayments'] = this.pendingPayments;
    data['latePayments'] = this.latePayments;
    data['confirmedInvoicesCount'] = this.confirmedInvoicesCount;
    return data;
  }
}

class Invoices {
  String? id;
  String? invoiceNumber;
  String? clientProfileId;
  String? workerProfileId;
  String? bankInfoId;
  String? dateIssued;
  String? duaDate;
  String? invoiceStatus;
  int? totalAmount;
  ClientProfile? clientProfile;
  ServiceRequest? serviceRequest;

  Invoices(
      {this.id,
      this.invoiceNumber,
      this.clientProfileId,
      this.workerProfileId,
      this.bankInfoId,
      this.dateIssued,
      this.duaDate,
      this.invoiceStatus,
      this.totalAmount,
      this.clientProfile,
      this.serviceRequest});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoiceNumber'];
    clientProfileId = json['clientProfileId'];
    workerProfileId = json['workerProfileId'];
    bankInfoId = json['bankInfoId'];
    dateIssued = json['dateIssued'];
    duaDate = json['duaDate'];
    invoiceStatus = json['invoiceStatus'];
    totalAmount = json['totalAmount'];
    clientProfile = json['ClientProfile'] != null
        ? new ClientProfile.fromJson(json['ClientProfile'])
        : null;
    serviceRequest = json['serviceRequest'] != null
        ? new ServiceRequest.fromJson(json['serviceRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoiceNumber'] = this.invoiceNumber;
    data['clientProfileId'] = this.clientProfileId;
    data['workerProfileId'] = this.workerProfileId;
    data['bankInfoId'] = this.bankInfoId;
    data['dateIssued'] = this.dateIssued;
    data['duaDate'] = this.duaDate;
    data['invoiceStatus'] = this.invoiceStatus;
    data['totalAmount'] = this.totalAmount;
    if (this.clientProfile != null) {
      data['ClientProfile'] = this.clientProfile!.toJson();
    }
    if (this.serviceRequest != null) {
      data['serviceRequest'] = this.serviceRequest!.toJson();
    }
    return data;
  }
}

class ClientProfile {
  User? user;

  ClientProfile({this.user});

  ClientProfile.fromJson(Map<String, dynamic> json) {
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;

  User({this.name});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ServiceRequest {
  User? taskType;

  ServiceRequest({this.taskType});

  ServiceRequest.fromJson(Map<String, dynamic> json) {
    taskType =
        json['TaskType'] != null ? new User.fromJson(json['TaskType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taskType != null) {
      data['TaskType'] = this.taskType!.toJson();
    }
    return data;
  }
}

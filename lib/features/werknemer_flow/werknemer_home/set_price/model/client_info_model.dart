class ClientInfoModel {
  final String location; //
  final DateTime dateTime;
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;

  ClientInfoModel({
    required this.location, //
    required this.dateTime,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
  });
}

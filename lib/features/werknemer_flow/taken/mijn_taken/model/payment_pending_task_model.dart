class PaymentPendingTaskModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final String date;
  final String time;
  final String invoiceStatus;
  final double totalAmount;
  final String invoiceNumber;

  PaymentPendingTaskModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.date,
    required this.time,
    required this.invoiceStatus,
    required this.totalAmount,
    required this.invoiceNumber,
  });

  factory PaymentPendingTaskModel.fromJson(Map<String, dynamic> json) {
    final invoice = json['Invoice'] ?? {};
    return PaymentPendingTaskModel(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      location: json['city'] ?? '',
      description: json['problemDescription'] ?? '',
      date: (json['preferredDate'] ?? '').toString().split('T')[0],
      time: (json['preferredTime'] ?? '')
          .toString()
          .split('T')[1]
          .substring(0, 5),
      invoiceStatus: invoice['invoiceStatus'] ?? '',
      totalAmount: (invoice['totalAmount'] ?? 0).toDouble(),
      invoiceNumber: invoice['invoiceNumber'] ?? '',
    );
  }
}

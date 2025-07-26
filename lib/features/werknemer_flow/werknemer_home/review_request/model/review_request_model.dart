class ReviewRequestModel {
  final String invoiceNumber;
  final String issuedDate;
  final String dueDate;
  final String clientName;
  final String clientPhone;
  final String clientEmail;
  final String clientCity;
  final String clientPostcode;
  final String employeeName;
  final String employeePhone;
  final Map<String, double> serviceDetails;
  final String bankName;
  final String iban;
  final String bic;

  ReviewRequestModel({
    required this.invoiceNumber,
    required this.issuedDate,
    required this.dueDate,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.clientCity,
    required this.clientPostcode,
    required this.employeeName,
    required this.employeePhone,
    required this.serviceDetails,
    required this.bankName,
    required this.iban,
    required this.bic,
  });

  double get total => serviceDetails.values.fold(0, (a, b) => a + b);
}

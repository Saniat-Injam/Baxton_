class SetPriceTaskModel {
  final String title;
  final String location;

  final String? shortDescription;
  final String? description;

  final DateTime dateTime;

  // Unnessary
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;
  final bool prepay;

  SetPriceTaskModel({
    required this.title,
    this.shortDescription,
    this.description,
    required this.location,
    required this.dateTime,

    // Unnessary
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.prepay = false,
  });
}

class AllTaskModel {
  final String title;
  final String shortDescription;
  final String description;
  final String location;
  final String price;
  final DateTime dateTime;
  bool isPaymentCompleted;

  AllTaskModel({
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.location,
    required this.price,
    required this.dateTime,
    this.isPaymentCompleted = false,
  });
}

class MyTask {
  final String id;
  final String title;
  final String location;
  final String shortDescription;
  final String description;
  final String price;
  final DateTime dateTime;
  final bool isPaymentCompleted;

  MyTask({
    required this.id,
    required this.title,
    required this.location,
    required this.shortDescription,
    required this.description,
    required this.price,
    required this.dateTime,
    required this.isPaymentCompleted,
  });

  factory MyTask.fromJson(Map<String, dynamic> json) {
    return MyTask(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      location: json['city'] ?? '',
      shortDescription: json['problemDescription'] ?? '',
      description: json['problemDescription'] ?? '',
      price: json['basePrice']?.toString() ?? '0',
      dateTime:
          DateTime.tryParse(json['preferredDate'] ?? '') ?? DateTime.now(),
      isPaymentCompleted: json['accept'] == true,
    );
  }
}

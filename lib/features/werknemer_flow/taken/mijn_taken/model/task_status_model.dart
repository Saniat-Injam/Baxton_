class TaskStatusModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final DateTime dateTime;
  final String status;
  final double basePrice;

  TaskStatusModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.dateTime,
    required this.status,
    required this.basePrice,
  });

  factory TaskStatusModel.fromJson(Map<String, dynamic> json) {
    return TaskStatusModel(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      location: json['city'] ?? '',
      description: json['problemDescription'] ?? '',
      dateTime: DateTime.parse(
        json['preferredDate'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? '',
      basePrice: (json['basePrice'] ?? 0).toDouble(),
    );
  }
}

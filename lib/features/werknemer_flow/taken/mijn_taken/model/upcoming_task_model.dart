class UpcomingTaskModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final String date;
  final String time;

  UpcomingTaskModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.date,
    required this.time,
  });

  factory UpcomingTaskModel.fromJson(Map<String, dynamic> json) {
    return UpcomingTaskModel(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      location: json['city'] ?? '',
      description: json['problemDescription'] ?? '',
      date: json['preferredDate']?.toString().split('T')[0] ?? '',
      time:
          json['preferredTime']?.toString().split('T')[1].substring(0, 5) ?? '',
    );
  }
}

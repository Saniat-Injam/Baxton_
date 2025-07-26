class Employee {
  final String name;
  final String role;
  final String imageUrl;
  final String? id;
  final String? phone;
  final String? email;
  final String? location;
  final String? joinDate;
  final String? expertise;
  final int? totalTasks;
  final int? pendingTasks;
  final int? completedTasks;
  final double? rating;

  Employee({
    required this.name,
    required this.role,
    required this.imageUrl,
    this.id,
    this.phone,
    this.email,
    this.location,
    this.joinDate,
    this.expertise,
    this.totalTasks,
    this.pendingTasks,
    this.completedTasks,
    this.rating,
  });
}

class Employee {
  final String name;
  final String role;
  final String imageUrl;

  Employee({required this.name, required this.role, required this.imageUrl});

  String get expertise => role;
}

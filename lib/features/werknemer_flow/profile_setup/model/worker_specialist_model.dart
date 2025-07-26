class WorkerSpecialist {
  final String id;
  final String name;

  WorkerSpecialist({required this.id, required this.name});

  factory WorkerSpecialist.fromJson(Map<String, dynamic> json) {
    return WorkerSpecialist(id: json['id'], name: json['name']);
  }
}

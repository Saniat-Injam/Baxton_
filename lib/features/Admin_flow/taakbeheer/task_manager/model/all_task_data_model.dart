class AllTasks {
  String? id;
  String? createdAt;
  String? propertyName;
  String? location;
  Worker? worker;
  String? status;

  // Constructor with null safety
  AllTasks({
    this.id,
    this.createdAt,
    this.propertyName,
    this.location,
    this.worker,
    this.status,
  });

  // Named constructor to create an object from JSON
  AllTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    createdAt = json['createdAt'] as String?;
    propertyName = json['propertyName'] as String?;
    location = json['location'] as String?;
    worker = json['worker'] != null ? Worker.fromJson(json['worker']) : null;
    status = json['status'] as String?;
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['propertyName'] = propertyName;
    data['location'] = location;
    if (worker != null) {
      data['worker'] = worker?.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Worker {
  String? id;
  String? name;

  // Constructor with null safety
  Worker({this.id, this.name});

  // Named constructor to create an object from JSON
  Worker.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class WorkerProfileData {
  final String name;
  final String email;
  final String phone;
  final String workerId;
  final String location;
  final String specialistId;
  final String? profileImageUrl;

  WorkerProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.workerId,
    required this.location,
    required this.specialistId,
    required this.profileImageUrl,
  });

  factory WorkerProfileData.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final profile = user['workerProfile'] ?? {};
    final pic = profile['profilePic'] ?? {};

    return WorkerProfileData(
      name: profile['userName'] ?? '',
      email: user['email'] ?? '',
      phone: user['phone'] ?? '',
      workerId: profile['workerId'] ?? '',
      location: profile['location'] ?? '',
      specialistId: profile['workerSpecialistId'] ?? '',
      profileImageUrl: pic['url'],
    );
  }
}

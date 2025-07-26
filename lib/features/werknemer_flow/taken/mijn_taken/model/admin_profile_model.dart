class AdminProfile {
  final String? id;
  final String? userId;
  final AdminUser? user;

  AdminProfile({this.id, this.userId, this.user});

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      id: json['id'],
      userId: json['userId'],
      user: json['User'] != null ? AdminUser.fromJson(json['User']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'User': user?.toJson()};
  }
}

class AdminUser {
  final String? id;
  final String? email;
  final String? phone;
  final String? name;
  final bool? isVerified;
  final String? userType;
  final bool? active;

  AdminUser({
    this.id,
    this.email,
    this.phone,
    this.name,
    this.isVerified,
    this.userType,
    this.active,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      isVerified: json['isVerified'],
      userType: json['UserType'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'isVerified': isVerified,
      'UserType': userType,
      'active': active,
    };
  }
}

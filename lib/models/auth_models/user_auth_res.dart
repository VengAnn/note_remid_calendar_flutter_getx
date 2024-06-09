class UserAuthRes {
  final User? user;
  final String? token;

  UserAuthRes({
    required this.user,
    required this.token,
  });

  factory UserAuthRes.fromJson(Map<String, dynamic> json) {
    return UserAuthRes(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user!.toJson(),
      'token': token,
    };
  }
}

class User {
  final int? userId;
  final String? name;
  final String? email;
  final String? profileUrl;
  final int status;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.profileUrl,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      profileUrl: json['profile_url'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'profile_url': profileUrl,
      'status': status,
    };
  }
}

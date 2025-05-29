class UserModel {
  final String email;
  final String password;

  UserModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class LoginResponse {
  final String token;
  final String email;
  final String fullName;
  final String role;
  final String username;

  LoginResponse({
    required this.token,
    required this.email,
    required this.fullName,
    required this.role,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return LoginResponse(
      token: data['token'] as String,
      email: data['email'] as String,
      fullName: data['full name'] as String,
      role: data['role'] as String,
      username: data['username'] as String,
    );
  }
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}

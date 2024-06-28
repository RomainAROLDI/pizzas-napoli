class User {
  final String id;
  final String email;
  final String? password;
  final String? accessToken;

  User(
      {required this.id, required this.email, this.password, this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      accessToken: json['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'access_token': accessToken,
    };
  }
}

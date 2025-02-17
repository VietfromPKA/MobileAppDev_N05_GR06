class User {
  final String id;
  final String email;
  final String username;
  final String password;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Provide a default value if id is null
      email: json['email'] ?? 'Unknown Email', // Provide a default value if email is null
      username: json['username'] ?? 'Unknown Username', // Provide a default value if username is null
      password: json['password'] ?? '', // Provide a default value if password is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}

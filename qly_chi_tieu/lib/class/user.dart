// user.dart

class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

// Đối tượng người dùng mẫu
List<User> predefinedUsers = [
  User(username: 'user1', password: 'pass1', role: 'Admin'),
  User(username: 'user2', password: 'pass2', role: 'Editor'),
  User(username: 'user3', password: 'pass3', role: 'Viewer'),
  User(username: 'user4', password: 'pass4', role: 'Admin'),
  User(username: 'user5', password: 'pass5', role: 'Viewer'),
];

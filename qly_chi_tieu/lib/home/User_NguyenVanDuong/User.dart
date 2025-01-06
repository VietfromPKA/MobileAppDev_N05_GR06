class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

// Tạo các đối tượng User
List<User> users = [
  User(username: "user1", password: "pass1", role: "admin"),
  User(username: "user2", password: "pass2", role: "user"),
  User(username: "user3", password: "pass3", role: "user"),
  User(username: "user4", password: "pass4", role: "moderator"),
  User(username: "user5", password: "pass5", role: "user")
];

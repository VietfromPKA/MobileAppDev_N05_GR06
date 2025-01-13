class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

final List<User> users = [
  User(username: "user1", password: "*****", role: "Admin"),
  User(username: "user2", password: "*****", role: "Editor"),
  User(username: "user3", password: "*****", role: "Viewer"),
  User(username: "user4", password: "*****", role: "Contributor"),
];

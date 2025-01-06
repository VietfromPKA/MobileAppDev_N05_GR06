class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

final List<User> users = [
  User(username: "john_doe", password: "1234", role: "Admin"),
  User(username: "jane_smith", password: "abcd", role: "Editor"),
  User(username: "michael_brown", password: "5678", role: "Viewer"),
  User(username: "emily_white", password: "efgh", role: "Contributor"),
  User(username: "david_black", password: "ijkl", role: "Moderator"),
];

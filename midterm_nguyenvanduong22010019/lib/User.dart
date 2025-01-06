class User {
  String username;
  String password;
  String role;

  User(this.username, this.password, this.role);

  @override
  String toString() {
    return 'User{username: $username, role: $role}';
  }
}

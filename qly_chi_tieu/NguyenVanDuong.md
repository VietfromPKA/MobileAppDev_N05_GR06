# User Management App - Nguyễn Văn Dương (22010019)

## 1. Ảnh chụp màn hình

Dưới đây là ảnh chụp màn hình Mobile App (trên web hoặc trên iOS hoặc trên Android):
![Screenshot](assets/images/Screenshot%202025-01-06%20143529.png)

## 2. Mã nguồn chính

### 2.1 Class User.dart

```dart
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
```
### 2.2 Class Main.dart
```dart
import 'package:flutter/material.dart';
import 'user.dart'; // Import file user.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserGridView(),
    );
  }
}

class UserGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Grid View')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text('Username: ${user.username}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Role: ${user.role}',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## 3.Link Github
[Link](https://github.com/VietfromPKA/MobileAppDev_N05_GR06)

## 4. Link ReadMe và ảnh chụp màn hình
[Link](NguyenVanDuong.md)
![Screenshot](assets/images/Screenshot%202025-01-06%20143529.png)

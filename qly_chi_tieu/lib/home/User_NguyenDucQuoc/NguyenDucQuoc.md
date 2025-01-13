# User Management App - Nguyễn Đức Quốc (22010234)

## Mô Tả
Cho phép người dùng nhập vào thông tin của các người dùng, bao gồm: 
- **Tên người dùng** (username)
- **Mật khẩu** (password)
- **Vai trò** (role)
Sau khi nhập thì thông tin sẽ hiển thị dưới dạng 'GridView'.

## Ảnh chụp màn hình
Ảnh chụp màn hình Mobile App (trên web hoặc trên iOS hoặc trên Android):
![Screenshot](assets\images\NguyenDucQuoc.png)

## Mã Nguồn
### 2.1 Class user.dart

```dart
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
```

### 2.2 Class DucQuoc-Screen.dart

```dart
import 'package:flutter/material.dart';
import 'user.dart';

void main() {
  runApp(DucQuocScreen());
}

class DucQuocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserGridScreen(),
    );
  }
}

class UserGridScreen extends StatefulWidget {
  @override
  _UserGridScreenState createState() => _UserGridScreenState();
}

class _UserGridScreenState extends State<UserGridScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  void _addUser() {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _roleController.text.isNotEmpty) {
      setState(() {
        users.add(User(
          username: _usernameController.text,
          password: _passwordController.text,
          role: _roleController.text,
        ));
      });

      // Xóa nội dung các ô sau khi thêm
      _usernameController.clear();
      _passwordController.clear();
      _roleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Danh sách người dùng",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Danh sách người dùng
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  color: Colors.black,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Username: ${user.username}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Password: ${user.password}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Role: ${user.role}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Khung nhập liệu
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _roleController,
                  decoration: InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _addUser,
                  child: Text("Thêm"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Link README
![Link](NguyenDucQuoc.md)

## Link Github
![Link](https://github.com/VietfromPKA/MobileAppDev_N05_GR06)
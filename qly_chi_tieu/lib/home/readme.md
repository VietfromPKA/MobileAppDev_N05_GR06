# User List App - Vu Quoc Viet

## Giới thiệu

Ứng dụng **User List App** cho phép người dùng nhập vào thông tin của các người dùng, bao gồm:
- **Tên người dùng** (username)
- **Mật khẩu** (password)
- **Vai trò** (role)

Sau khi người dùng nhập thông tin, danh sách người dùng sẽ được hiển thị ngay lập tức dưới dạng lưới `GridView`.

Ứng dụng này là một phần của dự án cá nhân của **Vu Quoc Viet**, mã sinh viên: **22010256**.

## Chức năng chính

- **Nhập thông tin người dùng**: Nhập các thông tin người dùng, bao gồm tên người dùng, mật khẩu, và vai trò.
- **Hiển thị thông tin người dùng**: Sau khi nhập, người dùng sẽ được hiển thị dưới dạng lưới `GridView`.
- **Điều hướng đến màn hình nhập thông tin**: Trên màn hình chính, bạn sẽ tìm thấy một nút có tên `vuquocviet_22010256`, khi nhấn vào nút này, bạn sẽ được chuyển đến màn hình nhập thông tin người dùng.
# User List App - Vu Quoc Viet

## Giới thiệu

Ứng dụng **User List App** được phát triển bằng Flutter cho phép người dùng nhập thông tin người dùng, bao gồm:
- **Tên người dùng** (username)
- **Mật khẩu** (password)
- **Vai trò** (role)

Sau khi người dùng nhập thông tin, ứng dụng sẽ hiển thị danh sách người dùng dưới dạng lưới `GridView`.

Ứng dụng này là một phần của dự án cá nhân của **Vu Quoc Viet**, mã sinh viên: **22010256**.

## Chức năng chính

- **Nhập thông tin người dùng**: Người dùng có thể nhập tên người dùng, mật khẩu, và vai trò.
- **Hiển thị danh sách người dùng**: Sau khi thông tin được nhập, người dùng sẽ thấy các bản ghi được hiển thị dưới dạng lưới `GridView`.
- **Điều hướng đến màn hình nhập thông tin**: Trên màn hình chính, có một nút có tên `vuquocviet_22010256`, khi nhấn vào nút này, người dùng sẽ được chuyển đến màn hình nhập thông tin người dùng.

## Mã nguồn chính

### 1. Class `User` (Định nghĩa đối tượng người dùng)

```dart
class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

final List<User> predefinedUsers = [
  User(username: 'admin', password: 'admin123', role: 'Admin'),
  User(username: 'editor', password: 'editor123', role: 'Editor'),
  User(username: 'viewer', password: 'viewer123', role: 'Viewer'),
  User(username: 'john_doe', password: 'johndoe123', role: 'Admin'),
  User(username: 'jane_doe', password: 'janedoe123', role: 'Editor'),
];
### 2. Main giao diện

```dart
import 'package:flutter/material.dart';
import 'user.dart'; // Import đối tượng người dùng từ user.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User List App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserInputScreen(), // Màn hình nhập và hiển thị danh sách người dùng
    );
  }
}

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final List<User> users = List.from(predefinedUsers); // Dùng danh sách đã định nghĩa sẵn từ user.dart
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  void _addUser() {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        roleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }

    setState(() {
      users.add(User(
        username: usernameController.text,
        password: passwordController.text,
        role: roleController.text,
      ));
    });

    // Xóa thông tin đã nhập sau khi thêm người dùng
    usernameController.clear();
    passwordController.clear();
    roleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nhập tên người dùng
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            
            // Nhập mật khẩu
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Ẩn mật khẩu khi nhập
            ),
            const SizedBox(height: 10),
            
            // Nhập vai trò
            TextField(
              controller: roleController,
              decoration: const InputDecoration(
                labelText: 'Vai trò',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            // Nút thêm người dùng
            ElevatedButton(
              onPressed: _addUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              ),
              child: Text('Thêm người dùng (${users.length})'),
            ),
            const SizedBox(height: 20),
            
            // Hiển thị danh sách người dùng
            Expanded(
              child: users.isEmpty
                  ? const Center(
                      child: Text(
                        'Chưa có người dùng nào.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Giảm số cột xuống 2
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person, color: Colors.blue, size: 50),
                                const SizedBox(height: 8),
                                Text(
                                  'Tên người dùng: ${user.username}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text('Vai trò: ${user.role}', style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


## Hướng dẫn sử dụng

1. **Cài đặt môi trường Flutter**:
   Đảm bảo rằng bạn đã cài đặt Flutter trên máy tính của mình. Nếu chưa, hãy làm theo hướng dẫn tại [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).

2. **Clone repository**:
   Clone repository này về máy tính của bạn bằng lệnh:
   ```bash
   git clone https://github.com/VietfromPKA/MobileAppDev_N05_GR06.git

3. **Chạy App**
    b1: cd ./qly_chi_tieu
    b2: flutter run

import 'package:flutter/material.dart';
import 'package:qly_chi_tieu/class/user.dart';

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

// Màn hình nhập và hiển thị danh sách người dùng
class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  // Sử dụng danh sách người dùng từ user.dart
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

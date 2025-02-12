import 'package:flutter/material.dart';
import 'user.dart';

void main() {
  runApp(const DucQuocScreen());
}

class DucQuocScreen extends StatelessWidget {
  const DucQuocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserGridScreen(),
    );
  }
}

class UserGridScreen extends StatefulWidget {
  const UserGridScreen({super.key});

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
        title: const Text(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        const Icon(
                          Icons.person,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "Username: ${user.username}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Password: ${user.password}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Role: ${user.role}",
                          style: const TextStyle(
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
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _addUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Thêm"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

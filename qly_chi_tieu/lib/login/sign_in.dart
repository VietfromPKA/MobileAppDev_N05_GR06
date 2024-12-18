import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  // Các controller để điều khiển các TextField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo ứng dụng
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              const SizedBox(height: 10),
              // Tiêu đề chào mừng người dùng
              const Text(
                'Đăng ký tài khoản',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Mô tả ngắn về màn hình đăng ký
              Text(
                'Tạo tài khoản mới để sử dụng FINIKAA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 28),
              // TextField nhập Tên
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên của bạn',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              // TextField nhập Email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              // TextField nhập mật khẩu
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              // TextField xác nhận mật khẩu
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Xác nhận mật khẩu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 28),
              // Nút đăng ký
              ElevatedButton(
                onPressed: () {
                  // Xử lý đăng ký tại đây
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Đăng Ký'),
              ),
              const SizedBox(height: 20),
              // Đoạn văn bản "Hoặc tiếp tục với"
              const Text('Hoặc tiếp tục với'),
              const SizedBox(height: 10),
              // Nút đăng nhập với các dịch vụ bên ngoài
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút đăng ký với Google
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png', height: 20),
                    label: const Text('Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Nút đăng ký với Facebook
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('assets/images/facebook.png', height: 20),
                    label: const Text('Facebook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Nút chuyển sang màn hình đăng nhập
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Quay lại màn hình đăng nhập
                },
                child: const Text('Đã có tài khoản? Đăng nhập ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // Các controller để điều khiển các TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Màu nền của màn hình
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Khoảng cách từ viền màn hình đến các widget con
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
          crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            // Tiêu đề chào mừng người dùng
            const Text(
              'Chào mừng bạn đã đến với',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Mô tả ngắn về màn hình đăng nhập
            Text(
              'Ứng dụng quản lý chi tiêu cá nhân',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            // TextField nhập Email
            TextField(
              controller: emailController, // Controller để điều khiển TextField
              decoration: const InputDecoration(
                labelText: 'Email', // Chú thích cho trường nhập liệu
                border: OutlineInputBorder(), // Viền cho TextField
                prefixIcon: Icon(Icons.email), // Biểu tượng Email
              ),
            ),
            const SizedBox(height: 16),
            // TextField nhập mật khẩu
            TextField(
              controller: passwordController,// Controller để điều khiển TextField
              obscureText: true, // Ẩn mật khẩu khi gõ
              decoration: InputDecoration(
                labelText: 'Mật khẩu', // Chú thích cho trường mật khẩu
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock), // Biểu tượng khóa
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility), // Biểu tượng hiện thị mật khẩu
                  onPressed: () {}, // Xử lý khi nhấn vào biểu tượng
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Nút "Quên Mật Khẩu?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Quên Mật Khẩu?'),
              ),
            ),
            const SizedBox(height: 30),
            // Nút đăng nhập
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng nhập tại đây
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Màu nền của nút
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Đăng Nhập'),
            ),
            const SizedBox(height: 20),
            // Đoạn văn bản "Hoặc tiếp tục với"
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hoặc tiếp tục với'),
              ],
            ),
            const SizedBox(height: 10),
            // Nút đăng nhập với các dịch vụ bên ngoài (Google, Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút đăng nhập với Google
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/google.png', height: 20),
                  label: const Text('Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black, // Màu chữ
                    side: const BorderSide(color: Colors.grey, width: 1), // Viền của nút
                  ),
                ),
                const SizedBox(width: 20),
                // Nút đăng nhập với Facebook
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/facebook.png', height: 20),
                  label: const Text('Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Màu chữ
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Nút để người dùng đăng ký nếu chưa có tài khoản
            TextButton(
              onPressed: () {},
              child: const Text('Không có tài khoản? Đăng ký ngay'),
            ),
          ],
        ),
      ),
    );
  }
}

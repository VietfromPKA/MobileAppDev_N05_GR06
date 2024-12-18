import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên Mật Khẩu'),
        backgroundColor: const Color.fromARGB(255, 255, 149, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Đặt lại mật khẩu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Nhập email của bạn để nhận liên kết đặt lại mật khẩu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 28),
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
            const SizedBox(height: 28),
            // Nút gửi yêu cầu đặt lại mật khẩu
            ElevatedButton(
              onPressed: () {
                // Xử lý gửi yêu cầu đặt lại mật khẩu tại đây
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Gửi liên kết'),
            ),
          ],
        ),
      ),
    );
  }
}

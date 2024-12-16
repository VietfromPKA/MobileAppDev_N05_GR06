import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Khởi chạy ứng dụng MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug trên ứng dụng
      home: LoginScreen(), // Màn hình đăng nhập làm trang chủ
    );
  }
}

class LoginScreen extends StatelessWidget {
  // Các controller để điều khiển các TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            Text(
              'Chào mừng bạn đã đến với',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Mô tả ngắn về màn hình đăng nhập
            Text(
              'Ứng dụng quản lý chi tiêu cá nhân',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            // TextField nhập Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email', // Chú thích cho trường nhập liệu
                border: OutlineInputBorder(), // Viền cho TextField
                prefixIcon: Icon(Icons.email), // Biểu tượng Email
              ),
            ),
            SizedBox(height: 16),
            // TextField nhập mật khẩu
            TextField(
              controller: passwordController,
              obscureText: true, // Ẩn mật khẩu khi gõ
              decoration: InputDecoration(
                labelText: 'Mật khẩu', // Chú thích cho trường mật khẩu
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock), // Biểu tượng khóa
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility), // Biểu tượng hiện thị mật khẩu
                  onPressed: () {}, // Xử lý khi nhấn vào biểu tượng
                ),
              ),
            ),
            SizedBox(height: 16),
            // Nút "Quên Mật Khẩu?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Quên Mật Khẩu?'),
              ),
            ),
            SizedBox(height: 30),
            // Nút đăng nhập
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng nhập tại đây
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Màu nền của nút
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Đăng Nhập'),
            ),
            SizedBox(height: 20),
            // Đoạn văn bản "Hoặc tiếp tục với"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hoặc tiếp tục với'),
              ],
            ),
            SizedBox(height: 10),
            // Nút đăng nhập với các dịch vụ bên ngoài (Google, Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút đăng nhập với Google
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/', height: 20),
                  label: Text('Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black, // Màu chữ
                    side: BorderSide(color: Colors.grey, width: 1), // Viền của nút
                  ),
                ),
                SizedBox(width: 20),
                // Nút đăng nhập với Facebook
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/fb_logo.svg', height: 20),
                  label: Text('Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Màu chữ
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Nút để người dùng đăng ký nếu chưa có tài khoản
            TextButton(
              onPressed: () {},
              child: Text('Không có tài khoản? Đăng ký ngay'),
            ),
          ],
        ),
      ),
    );
  }
}

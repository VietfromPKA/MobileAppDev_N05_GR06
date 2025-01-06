import 'package:flutter/material.dart';

// Hàm main: Điểm khởi đầu của ứng dụng
void main() {
  runApp(MyApp());
}

// Widget gốc của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tiêu đề của ứng dụng
      title: 'Flutter Layout Demo',
      // Định nghĩa chủ đề giao diện
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Widget chính khi ứng dụng khởi chạy
      home: MyHomePage(),
    );
  }
}

// Widget màn hình chính
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh AppBar hiển thị tiêu đề
      appBar: AppBar(
        title: const Text('Danh sách màu'),
      ),
      // Phần nội dung chính
      body: Column(
        children: [
          // Phần tiêu đề với khoảng cách
          const Padding(
            padding: EdgeInsets.all(16.0), // Khoảng cách 16 đơn vị
            child: Text(
              'Welcome to Flutter!',
              style: TextStyle(
                fontSize: 24, // Cỡ chữ 24
                fontWeight: FontWeight.bold, // In đậm
              ),
            ),
          ),
          // Đường kẻ ngang phân cách
          const Divider(),
          // Danh sách các mục
          Expanded(
            child: ListView.builder(
              // Tổng số mục trong danh sách
              itemCount: 12,
              // Hàm xây dựng từng mục trong danh sách
              itemBuilder: (context, index) {
                // Màu nền được chọn dựa trên chỉ số
                final backgroundColor =
                    Colors.primaries[index % Colors.primaries.length].shade300;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0), // Tạo lề xung quanh
                  child: Container(
                    height: 50,
                    color: backgroundColor, // Màu nền
                    child: ListTile(
                      leading: const Icon(Icons.star,
                          size: 20), // Biểu tượng bên trái// Thu nhỏ biểu tượng
                      title: Text(
                        'Mục ${index + 1}', // Tiêu đề
                        style: const TextStyle(
                            fontWeight: FontWeight.bold /*In đậm */,
                            fontSize: 14), // Giảm kích thước chữ
                      ),
                      subtitle: Text(
                        'Chọn mục ${index + 1}',
                        style: const TextStyle(fontSize: 12),
                      ), // Giảm kích thước chữ phụ),  // Phụ đề
                      trailing: const Icon(Icons.arrow_forward,
                          size: 20), // Biểu tượng bên phải
                      onTap: () {
                        // Khi người dùng nhấn vào mục
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã chọn mục: ${index + 1}')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

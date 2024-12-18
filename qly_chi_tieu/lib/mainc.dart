import 'package:flutter/material.dart';
import 'package:qly_chi_tieu/login/login.dart';

// Hàm main() là điểm bắt đầu của ứng dụng.
void main() {
  runApp(const MyApp());
}

// Widget MyApp là gốc của ứng dụng.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Tiêu đề của ứng dụng
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(
                255, 255, 116, 2)), // Tạo bảng màu từ màu chính
        useMaterial3: true, // Sử dụng Material Design 3
      ),
      debugShowCheckedModeBanner:
          false, // Ẩn banner "Debug" ở góc phải màn hình
      home: const MyHomePage(title: 'Quản lý chi tiêu'), // Giao diện chính
    );
  }
}

// Widget chính của ứng dụng với trạng thái có thể thay đổi
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // Tiêu đề của giao diện

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Lớp quản lý trạng thái của MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Biến lưu số lần bấm nút
  Color _selectedColor = Colors.white; // Biến lưu màu nền được chọn

  // Danh sách các màu có sẵn
  static const Map<String, Color> _colors = <String, Color>{
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Cyan': Colors.cyan,
    'Purple': Colors.purple,
    'Pink': Colors.pink,
    'Yellow': Colors.yellow,
  };

  // Hàm tăng giá trị đếm
  void _incrementCounter() {
    setState(() {
      _counter++; // Tăng biến đếm lên 1
    });
  }

  // Hàm giảm giá trị đếm
  void _decrementCounter() {
    setState(() {
      _counter--; // Giảm biến đếm đi 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary, // Đặt màu nền AppBar
        title: Text(widget.title), // Tiêu đề AppBar
      ),
      body: Container(
        color: _selectedColor, // Đặt màu nền của Container theo màu đã chọn
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Căn theo trục dọc, bắt đầu từ trên
          children: [
            const SizedBox(height: 20), // Khoảng cách phía trên
            Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Bạn đã nhấn nút bao nhiêu lần:', // Hiển thị nhãn
                  ),
                  Text(
                    '$_counter', // Hiển thị số lần đếm
                    // hiện thị màu nút tăng giảm theo màu đã chọn
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium, // Định dạng kiểu chữ
                  ),
                  const SizedBox(
                      height: 20), // Khoảng cách giữa số đếm và các nút
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Căn giữa các nút trên hàng ngang
                    children: [
                      // Nút giảm giá trị
                      FloatingActionButton(
                        onPressed: _decrementCounter, // Gọi hàm giảm
                        tooltip: 'Giảm', // Hiển thị tooltip khi nhấn giữ
                        child: const Icon(Icons.remove), // Icon cho nút giảm
                      ),
                      const SizedBox(width: 20), // Khoảng cách giữa 2 nút
                      // Nút tăng giá trị
                      FloatingActionButton(
                        onPressed: _incrementCounter, // Gọi hàm tăng
                        tooltip: 'Tăng', // Hiển thị tooltip khi nhấn giữ
                        child: const Icon(Icons.add), // Icon cho nút tăng
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Khoảng cách trước danh sách
            const Text(
              "Chọn màu nền:", // Tiêu đề cho danh sách màu
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold), // Định dạng chữ
            ),
            const SizedBox(height: 20), // Khoảng cách trước các màu
            Center(
              child: Wrap(
                spacing: 16.0, // Khoảng cách ngang giữa các mục
                runSpacing: 8.0, // Khoảng cách dọc giữa các mục khi xuống dòng
                alignment:
                    WrapAlignment.end, // Căn giữa các mục trong giao diện
                children: _colors.entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor =
                            entry.value; // Cập nhật màu nền khi nhấn
                      });
                    },
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Căn chỉnh chiều cao của cột
                      children: [
                        Container(
                          width: 48, // Kích thước của vòng tròn
                          height: 48, // Kích thước của vòng tròn
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Hình dạng của vòng tròn
                            border: Border.all(
                              color: Colors.black,
                              width: 2, // Độ rộng của viền vòng tròn
                            ),
                          ), // Hiển thị vòng tròn màu
                          child: CircleAvatar(
                            backgroundColor:
                                entry.value, // Màu nền của vòng tròn
                            radius: 24, // Bán kính của vòng tròn
                          ), // Hiển thị vòng tròn màu
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'calendar_screen.dart';
import 'report_screen.dart';
import 'other_screen.dart';

void main() => runApp(const ExpenseManagerApp());

class ExpenseManagerApp extends StatefulWidget {
  const ExpenseManagerApp({super.key});

  @override
  State<ExpenseManagerApp> createState() => _ExpenseManagerAppState();
}

class _ExpenseManagerAppState extends State<ExpenseManagerApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const InputScreen(),
    const CalendarScreen(),
    const ReportScreen(),
    const OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center, // Căn giữa logo trong AppBar
                  child: Image.asset(
                    'images/logo.png', // Đường dẫn tới logo trong thư mục assets
                    height: 50, // Chiều cao của logo
                  ),
                ),
              ),
              // Tiêu đề ứng dụng mặc định sẽ nằm ở bên trái
            ],
          ),
          backgroundColor: const Color.fromARGB(50, 255, 149, 0),
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 255, 149, 0),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Nhập'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Lịch'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Báo cáo'),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: 'Khác'),
          ],
        ),
      ),
    );
  }
}

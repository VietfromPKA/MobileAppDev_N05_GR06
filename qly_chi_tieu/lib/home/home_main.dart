import 'package:flutter/material.dart';
import 'package:qly_chi_tieu/home/DucQuoc-Screen.dart';
import 'package:qly_chi_tieu/home/VanDuong_Screen.dart';
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
    const UserInputScreen(),
    DucQuocScreen(),
    VanDuongScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_currentIndex], // Sử dụng từng màn hình riêng
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Nhập'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Lịch'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart), label: 'Báo cáo'),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: 'Khác'),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: 'Đức Quốc'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'Văn Dương'),
          ],
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

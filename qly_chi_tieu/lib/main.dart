// lib/main.dart
import 'package:flutter/material.dart';
//import './login/login.dart';  // Import tệp login.dart
import './home/home_main.dart'; // Import tệp home_main.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: ExpenseManagerApp(), // Chỉ định LoginScreen là trang chủ
    );
  }
}

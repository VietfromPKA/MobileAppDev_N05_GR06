// lib/main.dart
import 'package:flutter/material.dart';
import './login/login.dart';  // Import tệp login.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: LoginScreen(), // Chỉ định LoginScreen là trang chủ
    );
  }
}

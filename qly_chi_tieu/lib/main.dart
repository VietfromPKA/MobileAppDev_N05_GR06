// lib/main.dart
import 'package:flutter/material.dart';
import './login/login.dart';  // Import tệp login.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: LoginScreen(), // Chỉ định LoginScreen là trang chủ
    );
  }
}

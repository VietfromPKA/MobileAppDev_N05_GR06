import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
      ],
      child: MaterialApp(
        title: 'Quản lý Chi tiêu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

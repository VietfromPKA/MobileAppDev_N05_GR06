import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Màn hình Lịch',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

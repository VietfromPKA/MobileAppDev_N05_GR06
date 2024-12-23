import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Màn hình Báo cáo',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

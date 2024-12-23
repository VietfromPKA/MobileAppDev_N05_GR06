import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khác'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text(
          'Màn hình Khác',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

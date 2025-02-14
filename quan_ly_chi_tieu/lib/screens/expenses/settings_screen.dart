import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final String username;
  final String email;

  SettingsScreen({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Username: $username'),
            Text('Email: $email'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout logic here
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
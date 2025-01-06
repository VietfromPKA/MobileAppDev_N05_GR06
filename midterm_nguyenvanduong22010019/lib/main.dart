import 'package:flutter/material.dart';
import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<User> users = [
    User('user1', 'pass1', 'admin'),
    User('user2', 'pass2', 'editor'),
    User('user3', 'pass3', 'viewer'),
    User('user4', 'pass4', 'editor'),
    User('user5', 'pass5', 'admin'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('User Grid')),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(users[index].username),
                subtitle: Text(users[index].role),
              ),
            );
          },
        ),
      ),
    );
  }
}

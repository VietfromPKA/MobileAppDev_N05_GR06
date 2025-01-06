import 'package:flutter/material.dart';
import './User_NguyenVanDuong/User.dart';

void main() {
  runApp(ReportScreen());
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserGridView(),
    );
  }
}

class UserGridView extends StatelessWidget {
  const UserGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Grid View'), backgroundColor: Colors.cyanAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 40, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text('Username: ${user.username}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Role: ${user.role}',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

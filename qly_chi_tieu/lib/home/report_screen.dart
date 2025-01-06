import 'package:flutter/material.dart';
import './User_NguyenVanDuong/User.dart';

void main() {
  runApp(ReportScreen());
}

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserGridView(),
    );
  }
}

class UserGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Grid View'), backgroundColor: Colors.cyanAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    Icon(Icons.person, size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text('Username: ${user.username}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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

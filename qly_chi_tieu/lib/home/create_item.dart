import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const NewCategoryScreen(),
    );
  }
}

class NewCategoryScreen extends StatelessWidget {
  const NewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách các icon
    final List<IconData> icons = [
      Icons.shopping_cart,
      Icons.directions_car,
      Icons.flight,
      Icons.fastfood,
      Icons.cake,
      Icons.icecream,
      Icons.ramen_dining,
      Icons.local_pizza,
      Icons.directions_boat,
      Icons.sports_basketball,
      Icons.movie,
      Icons.coffee,
      Icons.star,
      Icons.desk,
      Icons.wine_bar,
      Icons.directions_bike,
    ];

    // Màu mặc định
    final Color defaultColor = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo mới'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên',
                hintText: 'Vui lòng nhập vào tên đề mục',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Biểu tượng',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return IconButton(
                    onPressed: () {
                      // Xử lý sự kiện khi chọn icon
                    },
                    icon: Icon(
                      icons[index],
                      color: Colors.orange, // Mặc định màu xám
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi lưu với màu mặc định
                  print('Lưu với màu: $defaultColor');
                },
                child: const Text('Lưu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String categoryName = ''; 
  IconData? selectedCategoryIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Ghi chú',
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewCategoryScreen(),
                  ),
                );
                if (result != null) {
                  setState(() {
                    categoryName = result['name'];
                    selectedCategoryIcon = result['icon'];
                  });
                }
              },
              child: _buildCategoryButton(Icons.add, 'Thêm mới'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String label) {
    return SizedBox(
      width: 60,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.orange),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
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

  String categoryName = '';
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo mới'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Trở về màn hình trước
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  categoryName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tên danh mục',
                hintText: 'Nhập tên danh mục',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chọn biểu tượng',
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
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icons[index];
                      });
                    },
                    child: Icon(
                      icons[index],
                      color: selectedIcon == icons[index] ? Colors.orange : Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (categoryName.isNotEmpty && selectedIcon != null) {
                    Navigator.pop(context, {'name': categoryName, 'icon': selectedIcon});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập đủ thông tin!')),
                    );
                  }
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

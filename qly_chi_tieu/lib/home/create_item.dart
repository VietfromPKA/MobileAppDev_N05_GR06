import 'package:flutter/material.dart';

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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  categoryName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tên',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Vui lòng nhập vào tên đề mục',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Biểu tượng',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icons[index];
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(207, 33, 33, 33),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icons[index],
                        color: selectedIcon == icons[index]
                            ? Colors.orange
                            : Colors.grey,
                        size: 30,
                      ),
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
                    Navigator.pop(
                        context, {'name': categoryName, 'icon': selectedIcon});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Vui lòng nhập đủ thông tin!')),
                    );
                  }
                },
                child: const Text('Lưu'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF121212),
    );
  }
}

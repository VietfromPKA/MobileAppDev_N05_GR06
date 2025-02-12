import 'package:flutter/material.dart';

void main() {
  runApp(const VanDuongScreen());
}

class VanDuongScreen extends StatelessWidget {
  const VanDuongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lá Phong Đỏ'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lá Phong Đỏ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Cảnh sắc mùa thu với những chiếc lá phong đỏ rực rỡ. Vẻ đẹp tự nhiên này chắc chắn sẽ làm say đắm bất kỳ ai chiêm ngưỡng.',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Đánh giá:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.yellow)),
                          ),
                          const SizedBox(height: 5),
                          const Text('250 Đánh giá'),
                          const SizedBox(height: 10),
                          const Text(
                            'Chi tiết:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('Địa điểm: Rừng phong Canada'),
                          const SizedBox(height: 5),
                          const Text('Thời gian tốt nhất để thăm: Mùa thu'),
                          const SizedBox(height: 5),
                          const Text('Hoạt động: Chụp ảnh, Thưởng ngoạn'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          '../assets/images/mua-thu.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.explore),
                label: const Text('Khám Phá Thêm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

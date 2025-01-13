import 'package:flutter/material.dart';

void main() {
  runApp(const VanDuongScreen());
}

class VanDuongScreen extends StatelessWidget {
  const VanDuongScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Strawberry Pavlova'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Strawberry Pavlova',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Rating:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.yellow)),
                    ),
                    const Text('170 Reviews'),
                    const SizedBox(height: 10),
                    const Text(
                      'Preparation and Cooking Time:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text('PREP: 29 min'),
                    const Text('COOK: 1 hr'),
                    const Text('FEEDS: 4-6'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Image.asset(
                  '../assets/images/anh-1.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

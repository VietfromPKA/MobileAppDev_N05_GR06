import 'package:flutter/material.dart';

void main() => runApp(const AppTestScreen());

class AppTestScreen extends StatelessWidget {
  const AppTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REVIEW BÁNH',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('REVIEW BÁNH'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Determine if the screen is a small device (e.g., phone) or large device (e.g., tablet, desktop)
            bool isSmallScreen = constraints.maxWidth < 600;

            return Row(
              children: [
                // Left Section (Adjustable 30%)
                Expanded(
                  flex: isSmallScreen ? 4 : 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Section
                        Flexible(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.lightBlue[50], // Light blue background
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Tiramisu Cake',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Description Section
                        Flexible(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.lightBlue[50], // Light blue background
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Tiramisu is a delightful dessert that perfectly combines the mild bitterness of coffee, the creamy richness of mascarpone, '
                              'and the soft texture of ladyfinger biscuits. The cocoa powder sprinkled on top adds an irresistible touch, making every bite flavorful and aromatic. '
                              'The harmonious blend of layers creates a melt-in-your-mouth sensation, leaving a sweet and unforgettable aftertaste.',
                              style: TextStyle(fontSize: 16),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // Rating and Reviews Row
                        Flexible(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.lightBlue[50], // Light blue background
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(Icons.star,
                                        color: Colors.black, size: 20),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '170 Reviews',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Combined Prep, Cook, Feeds Section
                        Flexible(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.lightBlue[50], // Light blue background
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildInfoColumn(
                                    Icons.timer, 'PREP:', '25 min'),
                                _buildInfoColumn(
                                    Icons.restaurant, 'COOK:', '1 hr'),
                                _buildInfoColumn(Icons.person, 'FEEDS:', '4-6'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Section (Adjustable 70%)
                Expanded(
                  flex: isSmallScreen ? 6 : 7,
                  child: Container(
                    color: Colors.grey,
                    child: const Center(
                      child: ImageSection(
                        image: 'images/anh1.jpg',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper function to create an info column
  Widget _buildInfoColumn(IconData icon, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.green, size: 28),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

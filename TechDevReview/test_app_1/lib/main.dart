import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Financal Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 15, 230, 33)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Color _themeColor = Colors.blueAccent;

  static const List<Map<String, dynamic>> _operations = [
    {'operation': '2 + 2', 'result': 2 + 2},
    {'operation': '3 * 3', 'result': 3 * 3},
    {'operation': '10 - 4', 'result': 10 - 4},
    {'operation': '16 / 2', 'result': 16 / 2},
  ];

  static const Map<String, Color> _colors = <String, Color>{
    'Black': Colors.black,
    'White': Colors.white,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateThemeColor(Color color) {
    setState(() {
      _themeColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _themeColor),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Financal Management'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: _selectedIndex == 0 ? _buildColorsPage() : _buildOperationsPage(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Colors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Operations',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 60, 214, 22),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildColorsPage() {
    return ListView(
      children: _colors.entries.map((entry) {
        return ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: entry.value,
          ),
          title: Text(entry.key),
          onTap: () {
            _updateThemeColor(entry.value);
          },
        );
      }).toList(),
    );
  }

  Widget _buildOperationsPage() {
    return ListView.builder(
      itemCount: _operations.length,
      itemBuilder: (context, index) {
        final operation = _operations[index];
        return ListTile(
          title: Text(operation['operation']),
          trailing: Text(operation['result'].toString()),
        );
      },
    );
  }
}

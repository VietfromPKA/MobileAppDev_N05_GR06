import 'package:flutter/material.dart';
import 'package:qly_chi_tieu/home/create_item.dart';
// Đảm bảo đã import màn hình NewCategoryScreen

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  DateTime selectedDate = DateTime.now(); // Biến lưu trữ ngày đã chọn
  String selectedType = 'Chi'; // Mặc định là 'Chi' (Khoản chi)
  String categoryName = ''; // Biến lưu trữ tên danh mục
  IconData? selectedCategoryIcon; // Biểu tượng được chọn cho danh mục

  // Hàm định dạng ngày
  String formatDate(DateTime date) {
    List<String> weekDays = [
      'CN',
      'Th 2',
      'Th 3',
      'Th 4',
      'Th 5',
      'Th 6',
      'Th 7'
    ];
    return '${date.day}/${date.month}/${date.year} (${weekDays[date.weekday % 7]})';
  }

  // Hàm chọn ngày
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Ngày mặc định
      firstDate: DateTime(2000), // Ngày bắt đầu
      lastDate: DateTime(2100), // Ngày kết thúc
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Cập nhật ngày đã chọn
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút chuyển sang Khoản chi
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'Chi'; // Chọn 'Chi' cho khoản chi
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selectedType == 'Chi' ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tiền chi',
                  style: selectedType == 'Chi'
                      ? const TextStyle(color: Colors.black)
                      : const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Nút chuyển sang Khoản thu
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'Thu'; // Chọn 'Thu' cho khoản thu
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selectedType == 'Thu' ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tiền thu',
                  style: selectedType == 'Thu'
                      ? const TextStyle(color: Colors.black)
                      : const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần chọn ngày
            Row(
              children: [
                const Text('Ngày',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDate(selectedDate),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(Icons.calendar_today,
                              color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Ghi chú',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                hintText: 'Chưa nhập vào',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            // Phần nhập số tiền (Khoản chi hoặc Khoản thu)
            TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: selectedType == 'Chi' ? 'Tiền chi' : 'Tiền thu',
                labelStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
                hintText: '0',
                suffixText: '₫',
                hintStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Danh mục',
                style: TextStyle(fontSize: 14, color: Colors.white)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: selectedType == 'Chi'
                    ? [
                        _buildCategoryButton(Icons.fastfood, 'Ăn uống'),
                        _buildCategoryButton(
                            Icons.shopping_bag, 'Chi tiêu hàng ngày'),
                        _buildCategoryButton(Icons.checkroom, 'Quần áo'),
                        _buildCategoryButton(Icons.face, 'Mỹ phẩm'),
                        _buildCategoryButton(Icons.local_bar, 'Phí giao lưu'),
                        _buildCategoryButton(Icons.local_hospital, 'Y tế'),
                        _buildCategoryButton(Icons.school, 'Giáo dục'),
                        _buildCategoryButton(Icons.water, 'Tiền điện'),
                        _buildCategoryButton(Icons.directions_bus, 'Đi lại'),
                        _buildCategoryButton(Icons.phone, 'Phí liên lạc'),
                        _buildCategoryButton(Icons.home, 'Tiền nhà'),
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
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        
                        ),
                      ]
                    : [
                        _buildCategoryButton(Icons.attach_money, 'Tiền lương'),
                        _buildCategoryButton(Icons.card_giftcard, 'Phụ cấp'),
                        _buildCategoryButton(Icons.emoji_events, 'Tiền thưởng'),
                        _buildCategoryButton(Icons.add_circle, 'Thu nhập phụ'),
                        _buildCategoryButton(Icons.trending_up, 'Đầu tư'),
                        _buildCategoryButton(Icons.inbox, 'Thu nhập tạm thời'),
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
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
            // Nút xác nhận
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng nhập khoản chi hoặc thu
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                    selectedType == 'Chi' ? 'Nhập khoản chi' : 'Nhập khoản thu',
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Màu nền của màn hình
    );
  }

  // Hàm xây dựng nút danh mục
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
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

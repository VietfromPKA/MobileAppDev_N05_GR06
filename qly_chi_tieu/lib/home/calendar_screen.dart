import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _PublicCalendarScreenState createState() => _PublicCalendarScreenState();
}

class _PublicCalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();

  final Map<String, List<Map<String, String>>> transactions = {
    "2024-12-01": [
      {'category': 'Đi lại', 'detail': 'Xăng xe', 'amount': '-50,000đ'},
    ],
    "2024-12-02": [
      {'category': 'Ăn uống', 'detail': 'Ăn sáng với MV', 'amount': '-50,000đ'},
    ],
    "2024-12-22": [
      {'category': 'Ăn uống', 'detail': 'Tiệc tất niên', 'amount': '-200,000đ'},
    ],
    "2024-12-23": [
      {'category': 'Mua sắm', 'detail': 'Mua quà Giáng Sinh', 'amount': '-500,000đ'},
    ],
    "2024-12-24": [
      {'category': 'Mua sắm', 'detail': 'Mua quà Giáng Sinh', 'amount': '-500,000đ'},
    ],
    "2024-12-25": [
      {'category': 'Mua sắm', 'detail': 'Mua quà Giáng Sinh', 'amount': '-500,000đ'},
    ],
    "2024-12-26": [
      {'category': 'Mua sắm', 'detail': 'Mua quà Giáng Sinh', 'amount': '-500,000đ'},
    ],
    "2024-12-27": [
      {'category': 'Mua sắm', 'detail': 'Mua quà Giáng Sinh', 'amount': '-500,000đ'},
    ],
  };

  List<int> _daysInMonth(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(lastDay.day, (index) => index + 1);
  }

  void _changeMonth(int offset) {
    setState(() {
      displayedMonth =
          DateTime(displayedMonth.year, displayedMonth.month + offset, 1);
    });
  }

  void onDaySelected(int day) {
    setState(() {
      selectedDate = DateTime(displayedMonth.year, displayedMonth.month, day);
    });
  }

  /// Tính toán số tiền đã sử dụng trong ngày
  int calculateDailyTotal(String date) {
    final dailyTransactions = transactions[date];
    if (dailyTransactions == null) return 0;

    int total = 0;
    for (var transaction in dailyTransactions) {
      final amountStr =
          transaction['amount']?.replaceAll('đ', '').replaceAll(',', '') ?? "0";
      total += int.parse(amountStr);
    }
    return total;
  }

  /// Lấy tất cả giao dịch trong tháng
  List<Map<String, String>> getMonthlyTransactions() {
    final List<Map<String, String>> monthlyTransactions = [];
    transactions.forEach((date, transactionList) {
      final transactionDate = DateTime.parse(date);
      if (transactionDate.year == displayedMonth.year &&
          transactionDate.month == displayedMonth.month) {
        monthlyTransactions.addAll(transactionList);
      }
    });
    return monthlyTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _daysInMonth(displayedMonth);
    final firstDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1);
    final prevMonthLastDay =
        DateTime(displayedMonth.year, displayedMonth.month, 0).day;
    final prevMonthDaysCount = firstDayOfMonth.weekday - 1;

    const weekDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];

    final monthlyTransactions = getMonthlyTransactions();

    // Calculate the total income and expenses
    int totalIncome = 0;
    int totalExpenses = 0;

    for (var transaction in monthlyTransactions) {
      final amountStr =
          transaction['amount']?.replaceAll('đ', '').replaceAll(',', '') ?? "0";
      final amount = int.parse(amountStr);

      if (amount > 0) {
        totalIncome += amount; // Income
      } else {
        totalExpenses += amount; // Expenses
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lịch Thu Chi Cá Nhân'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, color: Colors.white),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  "${displayedMonth.month}/${displayedMonth.year}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right, color: Colors.white),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade800,
              padding: const EdgeInsets.symmetric(
                  vertical: 4), // Giảm vertical padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekDays.map((day) {
                  return Text(
                    day,
                    style: TextStyle(
                      color: (day == "T7" || day == "CN")
                          ? Colors.red
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
            // lịch tháng hiện tại với các ngày được chia thành 6 hàng và 7 cột
            AspectRatio(
              aspectRatio: 1.6, // Đảm bảo chiều cao bằng chiều rộng
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8.0), // 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemCount: 42, // 6 rows * 7 days
                itemBuilder: (context, index) {
                  int day;
                  bool isFromCurrentMonth = true;
                  // Xác định ngày hiện tại thuộc tháng nào
                  if (index < prevMonthDaysCount) {
                    day = prevMonthLastDay - prevMonthDaysCount + index + 1;
                    isFromCurrentMonth = false;
                    // Nếu index lớn hơn số ngày của tháng hiện tại
                  } else if (index >= prevMonthDaysCount + daysInMonth.length) {
                    day = index - prevMonthDaysCount - daysInMonth.length + 1;
                    isFromCurrentMonth = false;
                    // Ngày trong tháng hiện tại
                  } else {
                    day = index - prevMonthDaysCount + 1;
                  }

                  final date = isFromCurrentMonth // Tạo DateTime từ ngày
                      ? DateTime(displayedMonth.year, displayedMonth.month, day)
                      : index < prevMonthDaysCount
                          ? DateTime(displayedMonth.year,
                              displayedMonth.month - 1, day)
                          : DateTime(displayedMonth.year,
                              displayedMonth.month + 1, day);

                  final isSelected = selectedDate.day == date.day && // Kiểm tra ngày được chọn
                      selectedDate.month == date.month &&
                      selectedDate.year == date.year;

                  final isWeekend = date.weekday == 6 || date.weekday == 7; // Kiểm tra ngày cuối tuần

                  final dailyTotal = isFromCurrentMonth // Tính toán số tiền đã sử dụng trong ngày
                      ? calculateDailyTotal(
                          date.toIso8601String().split('T')[0]) 
                      : 0;

                  return GestureDetector(
                    onTap: () => isFromCurrentMonth ? onDaySelected(day) : null,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black
                            : isWeekend
                                ? Colors.grey.shade700
                                : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: isFromCurrentMonth ? 1.0 : 0.5, // Điều chỉnh độ mờ
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : isWeekend
                                        ? isFromCurrentMonth
                                            ? Colors.red
                                            : Colors.grey
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isFromCurrentMonth)
                            Text(
                              '${dailyTotal}đ',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Tóm tắt thu chi
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              color: Colors.grey.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('Thu Nhập',
                          style: TextStyle(color: Colors.green)),
                      Text('${totalIncome}đ',
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Chi Tiêu',
                          style: TextStyle(color: Colors.red)),
                      Text('${totalExpenses}đ',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Tổng', style: TextStyle(color: Colors.white)),
                      Text('${totalIncome + totalExpenses}đ',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            // Giao dịch trong tháng
            ListView.builder(
              shrinkWrap:
                  true, // Đảm bảo ListView không chiếm quá nhiều không gian
              itemCount: monthlyTransactions.length,
              itemBuilder: (context, index) {
                final transaction = monthlyTransactions[index];
                return ListTile(
                  title: Text(transaction['category']!),
                  subtitle: Text(transaction['detail']!),
                  trailing: Text(
                    transaction['amount']!,
                    style: TextStyle(
                        color: transaction['amount']!.contains('-')
                            ? Colors.red
                            : Colors.green),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

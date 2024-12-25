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
      {
        'category': 'Mua sắm',
        'detail': 'Mua quà Giáng Sinh',
        'amount': '-500,000đ'
      },
      {'category': 'Mua sắm', 'detail': 'Mua quà tết', 'amount': '-1500,000đ'},
    ],
    "2024-12-24": [
      {
        'category': 'Mua sắm',
        'detail': 'Mua quà Giáng Sinh',
        'amount': '-500,000đ'
      },
    ],
    "2024-12-25": [
      {
        'category': 'Mua sắm',
        'detail': 'Mua quà Giáng Sinh',
        'amount': '-500,000đ'
      },
    ],
    "2024-12-26": [
      {
        'category': 'Mua sắm',
        'detail': 'Mua quà Giáng Sinh',
        'amount': '-500,000đ'
      },
    ],
    "2024-12-27": [
      {
        'category': 'Tiền Lương',
        'detail': 'Lương công ty XYZ',
        'amount': '500,000đ'
      },
    ],
  };

  /// Lấy danh sách các ngày trong tháng
  List<int> _daysInMonth(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(lastDay.day, (index) => index + 1);
  }

  /// Thay đổi tháng hiển thị
  void _changeMonth(int offset) {
    setState(() {
      displayedMonth =
          DateTime(displayedMonth.year, displayedMonth.month + offset, 1);
    });
  }

  /// Chọn ngày trong lịch
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0), // giảm chiều cao của AppBar
        child: AppBar(
          centerTitle: true,
          title: const Text('Lịch Thu Chi Cá Nhân'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.deepOrangeAccent,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(30.0), // chiều cao của container
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // căn giữa 2 phía của container
                mainAxisSize: MainAxisSize
                    .min, // chiều rộng của container bằng với nội dung
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
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade800,
            padding: const EdgeInsets.symmetric(vertical: 4), // vertical: chiều dọc
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
          AspectRatio(
            aspectRatio: 1.6,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), // vertical: chiều dọc
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: 42,
              itemBuilder: (context, index) {
                int day;
                bool isFromCurrentMonth = true;

                if (index < prevMonthDaysCount) {
                  day = prevMonthLastDay - prevMonthDaysCount + index + 1;
                  isFromCurrentMonth = false;
                } else if (index >= prevMonthDaysCount + daysInMonth.length) {
                  day = index - prevMonthDaysCount - daysInMonth.length + 1;
                  isFromCurrentMonth = false;
                } else {
                  day = index - prevMonthDaysCount + 1;
                }

                final date = isFromCurrentMonth
                    ? DateTime(displayedMonth.year, displayedMonth.month, day)
                    : index < prevMonthDaysCount
                        ? DateTime(
                            displayedMonth.year, displayedMonth.month - 1, day)
                        : DateTime(
                            displayedMonth.year, displayedMonth.month + 1, day);

                final isSelected = selectedDate.day == date.day &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;

                final isWeekend = date.weekday == 6 || date.weekday == 7;

                final dailyTotal = isFromCurrentMonth
                    ? calculateDailyTotal(date.toIso8601String().split('T')[0])
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
                          opacity: isFromCurrentMonth ? 1.0 : 0.5, // 50%
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4), // vertical: chiều dọc - horizontal: chiều ngang
            color: Colors.grey.shade800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Thu Nhập',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    Text('${totalIncome}đ',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Chi Tiêu',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    Text('${totalExpenses}đ',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Tổng',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('${totalIncome + totalExpenses}đ',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade500,
              child: ListView.builder(
                itemCount: monthlyTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = monthlyTransactions[index];

                  // Tìm ngày giao dịch dựa trên `transactions`
                  String? transactionDate;
                  transactions.forEach((date, transactionList) {
                    if (transactionList.contains(transaction)) {
                      transactionDate = date;
                    }
                  });
                  return ListTile(
                    title: Container(
                      width: MediaQuery.of(context) // lấy thông 
                          .size
                          .width, // chiều rộng của container bằng với màn hình
                      color: Colors.grey.shade600,
                      padding:
                          const EdgeInsets.all(4.0), // padding cho container
                      child: Text(
                        transactionDate ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    subtitle: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction['detail']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            transaction['amount']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: transaction['amount']!.contains('-')
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

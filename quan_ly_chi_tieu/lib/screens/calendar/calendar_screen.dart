import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();

  // Define a consistent color palette
  final Color _primaryColor = Colors.blueAccent;
  final Color _accentColor = Colors.greenAccent;
  final Color _selectedColor = Colors.blueAccent;
  final Color _textColor = Colors.black;
  final Color _subtextColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
    });
  }

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
    _showTransactionDetails(context);
  }

  int calculateDailyTotal(List<Expense> dailyTransactions) {
    if (dailyTransactions.isEmpty) return 0;

    int total = 0;
    for (var transaction in dailyTransactions) {
      total += transaction.amount.toInt();
    }
    return total;
  }

  List<Expense> getMonthlyTransactions(List<Expense> allExpenses) {
    return allExpenses
        .where((expense) =>
            expense.date.year == displayedMonth.year &&
            expense.date.month == displayedMonth.month)
        .toList();
  }
  // Helper function to get an icon based on the category
    IconData _getIconForCategory(String category) {
      switch (category) {
        case 'Ăn uống':
          return Icons.fastfood;
        case 'Mua sắm':
          return Icons.shopping_cart;
        case 'Di chuyển':
          return Icons.directions_car;
        case 'Hóa đơn':
          return Icons.receipt;
        case 'Giải trí':
          return Icons.movie;
        case 'Khác':
          return Icons.more_horiz;
        default:
          return Icons.attach_money; // Default icon
      }
    }


  void _showTransactionDetails(BuildContext context) {
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    final dayTransactions = expenseProvider.expenses
        .where((expense) =>
            expense.date.year == selectedDate.year &&
            expense.date.month == selectedDate.month &&
            expense.date.day == selectedDate.day)
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            final viewInsets = MediaQuery.of(context).viewInsets;
            return Padding(
              padding: EdgeInsets.only(bottom: viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Chi tiết giao dịch ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: TextStyle(
                          color: _textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    if (dayTransactions.isEmpty)
                      Text('Không có giao dịch nào.',
                          style: TextStyle(color: _subtextColor))
                    else
                      ...dayTransactions.map((transaction) => Card( // Wrap ListTile with Card
                        elevation: 2, // Add a subtle shadow
                        margin: const EdgeInsets.symmetric(vertical: 4), // Add some margin
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded corners
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add padding
                          leading: Icon(_getIconForCategory(transaction.category), color: _primaryColor), // Add an icon
                          title: Text(
                            transaction.category,
                            style: TextStyle(
                                color: _textColor, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            transaction.title,
                            style: TextStyle(color: _subtextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '${NumberFormat("#,##0", "vi_VN").format(transaction.amount)}đ',
                            style: TextStyle(
                              color: transaction.amount < 0
                                  ? Colors.redAccent
                                  : _accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _daysInMonth(displayedMonth);
    final firstDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1);
    final prevMonthDaysCount = firstDayOfMonth.weekday % 7;
    final totalDays = daysInMonth.length + prevMonthDaysCount;

    final weekDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final monthlyTransactions =
        getMonthlyTransactions(expenseProvider.expenses);

    int totalIncome = 0;
    int totalExpenses = 0;

    for (var transaction in monthlyTransactions) {
      if (transaction.amount < 0) {
        totalExpenses += transaction.amount.toInt().abs();
      } else {
        totalIncome += transaction.amount.toInt();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        title: const Text('Lịch Thu Chi Cá Nhân',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {}, // Placeholder for now
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left, color: _primaryColor),
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      "${displayedMonth.month}/${displayedMonth.year}",
                      style: TextStyle(
                          color: _primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right, color: _primaryColor),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Weekdays
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekDays.map((day) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: (day == "T7" || day == "CN")
                              ? Colors.redAccent
                              : _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Calendar
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0, // Make cells square
                  crossAxisSpacing: 4.0, // Reduced spacing
                  mainAxisSpacing: 4.0, // Reduced spacing
                ),
                itemCount: totalDays,
                itemBuilder: (context, index) {
                  int day = index - prevMonthDaysCount + 1;
                  bool isFromCurrentMonth =
                      index >= prevMonthDaysCount && day <= daysInMonth.length;

                  final date = isFromCurrentMonth
                      ? DateTime(displayedMonth.year, displayedMonth.month, day)
                      : null;

                  final isSelected = date != null && selectedDate == date;

                  final dailyTransactions = date != null
                      ? expenseProvider.expenses.where((expense) =>
                          expense.date.year == date.year &&
                          expense.date.month == date.month &&
                          expense.date.day == date.day).toList()
                      : <Expense>[];


                      // Check if the date has transactions
                    final hasTransactions = dailyTransactions.isNotEmpty;

                  return GestureDetector(
                    onTap: isFromCurrentMonth ? () => onDaySelected(day) : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200), // Shorter duration
                      decoration: BoxDecoration(
                        color: isSelected ? _selectedColor : (hasTransactions ? _accentColor.withOpacity(0.2): Colors.grey.shade100), // Highlight days with transactions
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2)
                            : Border.all(color: Colors.grey.shade300, width: 1), // Subtle border
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isFromCurrentMonth ? '$day' : '',
                              style: TextStyle(
                                color: isSelected ? Colors.white : _textColor,
                                fontWeight: FontWeight.w600, // Slightly less bold
                              ),
                            ),
                           if (hasTransactions) // Show a dot indicator if there are transactions
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: CircleAvatar(
                                  radius: 3, // Adjust size as needed
                                    backgroundColor: isSelected ? Colors.white : _primaryColor,
                                ),
                              ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24), // More space
              // Summary
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                   boxShadow: [ // Add a subtle shadow
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummary('Thu Nhập', totalIncome, _accentColor),
                    _buildSummary('Chi Tiêu', totalExpenses, Colors.redAccent),
                    _buildSummary(
                        'Tổng', totalIncome - totalExpenses, _primaryColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(String label, int amount, Color color) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('${NumberFormat("#,##0", "vi_VN").format(amount)}đ',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)), // Larger font
      ],
    );
  }
}
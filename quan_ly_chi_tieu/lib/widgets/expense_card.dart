import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/screens/expenses/expense_detail_screen.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ExpenseDetailScreen(expense: expense),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  // Use consistent colors based on expense.type
                  color: expense.type == 'Thu nhập'
                      ? CupertinoColors.activeGreen.withOpacity(0.2)
                      : CupertinoColors.systemRed.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  // Use consistent icons based on expense.type
                  expense.type == 'Thu nhập'
                      ? CupertinoIcons.arrow_down_circle_fill
                      : CupertinoIcons.arrow_up_circle_fill,
                  color: expense.type == 'Thu nhập'
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.systemRed,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      // Use NumberFormat and display type
                      '${NumberFormat("#,##0", "vi_VN").format(expense.amount.abs())} VNĐ - ${expense.category}',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                  Text(
                    expense.type, // Display "Thu nhập" or "Chi tiêu"
                    style: TextStyle(
                      color: expense.type == 'Thu nhập'
                          ? CupertinoColors.activeGreen // Green for income
                          : CupertinoColors.systemRed, // Red for expense
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  _showDeleteConfirmationDialog(context);
                },
                child: const Icon(CupertinoIcons.delete,
                    color: CupertinoColors.systemRed),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa giao dịch này?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true, // Make the delete button red
              child: const Text('Xóa'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog first
                try {
                  await Provider.of<ExpenseProvider>(context, listen: false)
                      .deleteExpense(expense);
                } catch (error) {
                  // Show an error message using CupertinoAlertDialog
                  _showErrorDialog(context, 'Xóa giao dịch không thành công: ${error.toString()}');

                }
              },
            ),
          ],
        );
      },
    );
  }
    void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
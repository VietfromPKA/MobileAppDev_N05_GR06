import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_chi_tieu/widgets/edit_expense_form.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Chi tiết chi tiêu'),
        backgroundColor: CupertinoColors.systemTeal,
        previousPageTitle: "Back",
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // Center everything vertically
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center horizontally within the row
                    children: [
                      Expanded(
                        child: Text(
                          expense.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center, // Center the text itself
                        ),
                      ),
                      Icon(
                        expense.type == 'Income'
                            ? CupertinoIcons.arrow_down_circle_fill
                            : CupertinoIcons.arrow_up_circle_fill,
                        color: expense.type == 'Income'
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemRed,
                        size: 32.0,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  _buildDetailRow(
                    context,
                    CupertinoIcons.money_dollar_circle,
                    'Số tiền: ${NumberFormat("#,##0", "vi_VN").format(expense.amount)} VNĐ',
                  ),

                  _buildDetailRow(
                    context,
                    CupertinoIcons.tag,
                    'Phân loại: ${expense.category}',
                  ),
                  _buildDetailRow(
                    context,
                    CupertinoIcons.calendar,
                    'Ngày: ${expense.date.day}/${expense.date.month}/${expense.date.year}',
                  ),

                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    onPressed: () async {
                      final updatedExpense = await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditExpenseForm(expense: expense),
                        ),
                      );

                      if (updatedExpense != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cập nhật chi tiêu thành công!')),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.pencil, color: CupertinoColors.white),
                        const SizedBox(width: 8),
                        const Text('Chỉnh sửa', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the row
        children: [
          Icon(icon, color: CupertinoColors.systemGrey, size: 24.0),
          const SizedBox(width: 10),
          Expanded( // Keep Expanded for text wrapping
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: CupertinoColors.systemGrey.resolveFrom(context),
              ),
              textAlign: TextAlign.center, // Center the text within the Expanded
            ),
          ),
        ],
      ),
    );
  }
}
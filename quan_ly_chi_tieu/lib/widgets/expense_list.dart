import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/widgets/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return ListView.builder(
      itemCount: expenseProvider.expenses.length,
      itemBuilder: (context, index) {
        final expense = expenseProvider.expenses[index];
        return ExpenseCard(
          expense: expense,
          onTap: () {
            // Xử lý khi người dùng nhấn vào thẻ chi tiêu
          },
        );
      },
    );
  }
}

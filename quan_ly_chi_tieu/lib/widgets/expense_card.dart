import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseCard({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text('${expense.amount.toString()} VNĐ - ${expense.category}'),
        trailing: Text(
          '${expense.date.day}/${expense.date.month}/${expense.date.year}',
          style: TextStyle(color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}

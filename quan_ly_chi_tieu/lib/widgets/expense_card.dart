import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/screens/expense_detail_screen.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: expense.type == 'Income' ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            expense.type == 'Income' ? Icons.arrow_downward : Icons.arrow_upward,
            color: expense.type == 'Income' ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          '${expense.amount.toString()} VNĐ - ${expense.category}',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Wrap(
          spacing: 8, // space between two icons
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  expense.type,
                  style: TextStyle(
                    color: expense.type == 'Income' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                try {
                  await Provider.of<ExpenseProvider>(context, listen: false).deleteExpense(expense);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete expense: ${error.toString()}')),
                  );
                }
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpenseDetailScreen(expense: expense),
            ),
          );
        },
      ),
    );
  }
}

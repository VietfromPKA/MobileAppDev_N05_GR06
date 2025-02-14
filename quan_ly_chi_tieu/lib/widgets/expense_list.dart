import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/widgets/expense_card.dart';
import 'package:quan_ly_chi_tieu/screens/expenses/add_expense_screen.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Chi tiêu'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return ExpenseCard(expense: expense);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        backgroundColor: Colors.teal,
        tooltip: 'Thêm chi tiêu',
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:quan_ly_chi_tieu/widgets/expense_list.dart';
import 'package:quan_ly_chi_tieu/screens/add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Chi tiêu'),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return provider.expenses.isEmpty
              ? Center(child: Text('Chưa có chi tiêu nào'))
              : ExpenseList();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        tooltip: 'Thêm chi tiêu',
        child: Icon(Icons.add),
      ),
    );
  }
}

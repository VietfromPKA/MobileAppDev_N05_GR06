import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/widgets/add_expense_form.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm chi tiêu'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: AddExpenseForm(),
      ),
    );
  }
}

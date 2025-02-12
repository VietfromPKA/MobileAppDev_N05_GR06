import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:uuid/uuid.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Tiêu đề'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tiêu đề';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Số tiền'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập số tiền';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Phân loại'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập phân loại';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final expense = Expense(
                  id: uuid.v4(),
                  title: _titleController.text,
                  amount: double.parse(_amountController.text),
                  date: DateTime.now(),
                  category: _categoryController.text,
                );
                Provider.of<ExpenseProvider>(context, listen: false)
                    .addExpense(expense);
                Navigator.pop(context);
              }
            },
            child: Text('Thêm chi tiêu'),
          ),
        ],
      ),
    );
  }
}

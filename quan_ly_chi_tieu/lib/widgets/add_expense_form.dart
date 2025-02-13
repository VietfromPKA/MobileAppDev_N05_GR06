import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:uuid/uuid.dart';

class AddExpenseForm extends StatefulWidget {
  final Expense? expense;

  const AddExpenseForm({super.key, this.expense});

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final Uuid uuid = Uuid();
  String? _selectedCategory;
  String? _selectedType;
  final List<String> _categories = ['Ăn uống', 'Di chuyển', 'Giải trí', 'Sức khỏe', 'Khác'];
  final List<String> _types = ['Thu nhập', 'Chi tiêu'];

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.toString();
      _selectedCategory = widget.expense!.category;
      _selectedType = widget.expense!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Tiêu đề',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tiêu đề';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Số tiền',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số tiền';
                }
                try {
                  double.parse(value);
                } catch (e) {
                  return 'Số tiền phải là một số hợp lệ';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedType,
              hint: Text('Chọn loại giao dịch'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.swap_vert),
              ),
              items: _types.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              validator: (value) {
                if (value == null || !_types.contains(value)) {
                  return 'Vui lòng chọn loại giao dịch hợp lệ';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text('Chọn phân loại'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || !_categories.contains(value)) {
                  return 'Vui lòng chọn phân loại hợp lệ';
                }
                return null;
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final expense = Expense(
                    id: widget.expense?.id ?? uuid.v4(),
                    title: _titleController.text,
                    amount: double.parse(_amountController.text), // Chuyển đổi kiểu dữ liệu amount sang double
                    date: widget.expense?.date ?? DateTime.now(),
                    category: _selectedCategory ?? 'Other',
                    type: _selectedType ?? 'Expense',
                  );
                  if (widget.expense == null) {
                    await Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: Text(widget.expense == null ? 'Thêm giao dịch' : 'Cập nhật giao dịch'),
            ),
          ],
        ),
      ),
    );
  }
}

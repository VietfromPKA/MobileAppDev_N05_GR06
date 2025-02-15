import 'package:flutter/cupertino.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/widgets/add_expense_form.dart';

class EditExpenseForm extends StatelessWidget {
  final Expense expense;

  const EditExpenseForm({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Chỉnh sửa giao dịch'), // Vietnamese title
         // Add back button
        leading: CupertinoNavigationBarBackButton(
            onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/home_screen', (Route<dynamic> route) => false); // Go back to the home screen
          },
        ),
      ),
      child: SafeArea(
        child: AddExpenseForm(expense: expense), // Pass the expense to the form
      ),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/services/api_service.dart';

class ExpenseProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Expense> _expenses = [];
  List<Expense> _filteredExpenses = [];

  ExpenseProvider() {
    fetchExpenses();
  }

  List<Expense> get expenses => _filteredExpenses;

  Future<void> fetchExpenses() async {
    try {
      _expenses = await _apiService.getAllExpenses();
      _filteredExpenses = _expenses;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      final newExpense = await _apiService.addExpense(expense);
      _expenses.add(newExpense);
      _filteredExpenses = List.from(_expenses); // Chỉ cập nhật _filteredExpenses một lần
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      await _apiService.deleteExpense(expense);
      _expenses.removeWhere((e) => e.id == expense.id);
      _filteredExpenses = List.from(_expenses);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete expense');
    }
  }

  void searchExpenses(String query) {
    if (query.isEmpty) {
      _filteredExpenses = _expenses;
    } else {
      _filteredExpenses = _expenses
          .where((expense) =>
              expense.title.toLowerCase().contains(query.toLowerCase()) ||
              expense.category.toLowerCase().contains(query.toLowerCase()) ||
              expense.amount.toString().contains(query) ||
              expense.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

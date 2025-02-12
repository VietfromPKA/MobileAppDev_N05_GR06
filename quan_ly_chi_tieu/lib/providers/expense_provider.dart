import 'package:flutter/foundation.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/services/api_service.dart';

class ExpenseProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Expense> _expenses = [];

  ExpenseProvider() {
    fetchExpenses();
  }

  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    try {
      _expenses = await _apiService.getAllExpenses();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      final newExpense = await _apiService.addExpense(expense);
      _expenses.add(newExpense);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _apiService.updateExpense(expense);
      final index = _expenses.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        _expenses[index] = expense;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      await _apiService.deleteExpense(expense);
      _expenses.removeWhere((e) => e.id == expense.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

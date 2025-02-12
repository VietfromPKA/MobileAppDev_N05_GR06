import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quan_ly_chi_tieu/models/expense.dart';

class ApiService {
  final String baseUrl = 'http://10.6.136.115:3000'; // URL của API trên máy tính cục bộ với địa chỉ IP

  Future<List<Expense>> getAllExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/expenses'));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((data) => Expense.fromMap(data)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<Expense> addExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(expense.toMap()),
    );

    if (response.statusCode == 201) {
      return Expense.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add expense');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/expenses/${expense.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(expense.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/expenses/${expense.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete expense');
    }
  }
}

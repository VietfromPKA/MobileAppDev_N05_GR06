import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quan_ly_chi_tieu/models/expense.dart';

class ApiService {
  final String baseUrl = 'http://192.168.102.17:3000'; // Your API URL

  Future<List<Expense>> getAllExpenses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/expenses'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Expense.fromMap(data)).toList();
      } else {
        throw Exception('Failed to load expenses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load expenses: $e');
    }
  }

  Future<Expense> addExpense(Expense expense) async {
    try {
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
        throw Exception('Failed to add expense: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      final response = await http.patch(  // Or put, depending on your API
        Uri.parse('$baseUrl/expenses/${expense.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expense.toMap()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update expense: ${response.statusCode}');
      }
    } catch(e) {
        throw Exception('Failed to update expense: $e');
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/expenses/${expense.id}'),
        headers: <String, String>{ // Include headers even for DELETE
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete expense: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }
}
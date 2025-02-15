import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://192.168.102.17:3000/auth';

  static var userId; // Địa chỉ IP của máy tính

  Future<void> login(String email, String password, dynamic userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userId = responseData['userId']; // Lưu trữ userId sau khi đăng nhập thành công
    } else {
      try {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message']);
      } catch (e) {
        throw Exception('Failed to login');
      }
    }
  }

  Future<void> register(String email, String password, String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password, 'username': username}),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      try {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message']);
      } catch (e) {
        throw Exception('Failed to register');
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset email');
    }
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}), // Gửi userId để đăng xuất
    );

    if (response.statusCode == 200) {
      userId = null; // Xóa userId sau khi đăng xuất thành công
    } else {
      try {
        final responseBody = response.body; // Lưu trữ nội dung phản hồi
        if (responseBody.startsWith('<!DOCTYPE html>')) {
          throw Exception('Server returned an HTML response');
        }
        final responseData = jsonDecode(response.body);
        throw Exception('Failed to logout: ${responseData['message']} - Response: $responseBody');
      } catch (e) {
        throw Exception('Failed to logout: $e');
      }
    }
  }
}

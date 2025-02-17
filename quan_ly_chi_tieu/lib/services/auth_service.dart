import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quan_ly_chi_tieu/models/user.dart';

class AuthService {
  final String baseUrl = 'http://10.6.136.124:3000/auth'; // Cập nhật URL của máy chủ
  static User? currentUser; // Thông tin người dùng hiện tại

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Response: ${response.body}'); // In ra nội dung phản hồi để kiểm tra

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData == null || responseData['user'] == null) {
        throw Exception('User data is null');
      }
      currentUser = User.fromJson(responseData['user']); // Lưu trữ thông tin người dùng sau khi đăng nhập thành công
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
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password, 'username': username}),
      );

      print('Response: ${response.body}'); // In ra nội dung phản hồi để kiểm tra

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData == null || responseData['user'] == null) {
          throw Exception('User data is null');
        }
        currentUser = User.fromJson(responseData['user']); // Lưu trữ thông tin người dùng sau khi đăng ký thành công
      } else {
        final responseBody = response.body; // Lưu trữ nội dung phản hồi
        final responseData = jsonDecode(responseBody);
        print('Error: ${responseData['message']}'); // Ghi lại lỗi để kiểm tra
        throw Exception(responseData['message']);
      }
    } catch (e) {
      print('Error: Failed to register. Exception: $e'); // In ra lỗi chi tiết để kiểm tra
      throw Exception('Failed to register. Exception: $e');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      currentUser = user; // Cập nhật thông tin người dùng hiện tại
    } else {
      try {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message']);
      } catch (e) {
        throw Exception('Failed to update user');
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
      body: jsonEncode({'userId': currentUser?.id}), // Gửi userId để đăng xuất
    );

    if (response.statusCode == 200) {
      currentUser = null; // Xóa thông tin người dùng sau khi đăng xuất thành công
    } else {
      try {
        final responseBody = response.body;
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

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quan_ly_chi_tieu/models/user.dart';

class AuthService {
  // duong
  final String baseUrl = 'http://10.6.136.124:3000/auth';

  // viet
  // final String baseUrl = 'http://192.168.1.3:3000/auth';

  static User? currentUser; // Thông tin người dùng hiện tại

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String userId = responseData['user']['id'] ?? ''; // Cung cấp giá trị mặc định nếu userId là null
      String userEmail = responseData['user']['email'] ?? 'Unknown Email'; // Cung cấp giá trị mặc định nếu email là null
      String userUsername = responseData['user']['username'] ?? 'Unknown Username'; // Cung cấp giá trị mặc định nếu username là null
      currentUser = User(
        id: userId,
        email: userEmail,
        username: userUsername,
        password: password,
      ); // Lưu trữ thông tin người dùng sau khi đăng nhập thành công
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
      final responseData = jsonDecode(response.body);
      String userId = responseData['user']['id'] ?? ''; // Cung cấp giá trị mặc định nếu userId là null
      String userEmail = responseData['user']['email'] ?? 'Unknown Email'; // Cung cấp giá trị mặc định nếu email là null
      String userUsername = responseData['user']['username'] ?? 'Unknown Username'; // Cung cấp giá trị mặc định nếu username là null
      currentUser = User(
        id: userId,
        email: userEmail,
        username: userUsername,
        password: password,
      ); // Lưu trữ thông tin người dùng sau khi đăng ký thành công
    } else {
      try {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message']);
      } catch (e) {
        throw Exception('Failed to register');
      }
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

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quan_ly_chi_tieu/models/user.dart';

class AuthService {
  // duong
  final String baseUrl = 'http://10.6.136.171:3000/auth';

  // viet
  // final String baseUrl = 'http://192.168.1.3:3000/auth';

  static User? currentUser; // Thông tin người dùng hiện tại

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String userId = responseData['user']['_id'] ?? '';
      String userEmail = responseData['user']['email'] ?? 'Unknown Email';
      String userUsername = responseData['user']['username'] ?? 'Unknown Username';
      currentUser = User(
        id: userId,
        email: userEmail,
        username: userUsername,
        password: password,
      ); // Lưu trữ thông tin người dùng sau khi đăng nhập thành công
      await getUserData(); // Gọi getUserData để chắc chắn rằng thông tin người dùng được tải
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
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password, 'username': username}),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      String userId = responseData['user']['_id'] ?? '';
      String userEmail = responseData['user']['email'] ?? 'Unknown Email';
      String userUsername = responseData['user']['username'] ?? 'Unknown Username';
      currentUser = User(
        id: userId,
        email: userEmail,
        username: userUsername,
        password: password,
      ); // Lưu trữ thông tin người dùng sau khi đăng ký thành công
      await getUserData(); // Gọi getUserData để chắc chắn rằng thông tin người dùng được tải
    } else {
      try {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message']);
      } catch (e) {
        throw Exception('Failed to register');
      }
    }
  }

  Future<void> getUserData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/${currentUser?.id}'), // Endpoint để lấy thông tin người dùng
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['user'] == null) {
        throw Exception('No user data found');
      }
      currentUser = User.fromJson(responseData['user']); // Lưu trữ thông tin người dùng
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
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
      Uri.parse('$baseUrl/auth/logout'),
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

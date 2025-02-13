import 'package:quan_ly_chi_tieu/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserDataService {
  final String baseUrl = 'http://192.168.102.17:3000/'; // Địa chỉ IP của máy tính

  Future<void> getUserData() async {
    if (AuthService.userId == null) {
      throw Exception('User is not logged in');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/data/${AuthService.userId}'), // Sử dụng userId để kết nối đến collection của người dùng
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Xử lý dữ liệu người dùng
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

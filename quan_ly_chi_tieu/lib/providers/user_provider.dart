import 'package:flutter/foundation.dart';
import 'package:quan_ly_chi_tieu/services/auth_service.dart';
import 'package:quan_ly_chi_tieu/models/user.dart';

class UserProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    _currentUser = AuthService.currentUser;
    notifyListeners();
  }

  Future<void> register(String email, String password, String username) async {
    await _authService.register(email, password, username);
    _currentUser = AuthService.currentUser;
    notifyListeners();
  }

  Future<void> getUserData() async {
    await _authService.getUserData();
    _currentUser = AuthService.currentUser;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:quan_ly_chi_tieu/services/auth_service.dart'; // Import AuthService
import 'package:quan_ly_chi_tieu/models/user.dart'; // Import User model

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Thêm các TextEditingController để quản lý các trường dữ liệu
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  // Thêm biến để lưu trạng thái chỉnh sửa
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Load thông tin user vào đây
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = AuthService.currentUser; // Lấy thông tin người dùng hiện tại từ AuthService
      if (userData != null) {
        _usernameController.text = userData.username;
        _emailController.text = userData.email;
      }
    } catch (e) {
      _showErrorDialog('Lỗi tải thông tin người dùng: $e');
    } finally {
      setState(() {});
    }
  }

  Future<void> _saveUserData() async {
    try {
      final updatedUser = User(
        id: AuthService.currentUser!.id,
        email: _emailController.text,
        username: _usernameController.text,
        password: AuthService.currentUser!.password, // Giữ nguyên mật khẩu
      );

      await AuthService().updateUser(updatedUser); // Gọi API để cập nhật thông tin người dùng
      setState(() {
        _isEditing = false; // Tắt chế độ chỉnh sửa sau khi lưu
      });
      _showSuccessDialog(); // Hiển thị thông báo
    } catch (e) {
      _showErrorDialog('Lỗi lưu thông tin người dùng: $e');
    }
  }

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Thành công'),
          content: const Text('Đã lưu thông tin.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text(errorMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Thông tin cá nhân'),
        trailing: _isEditing
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Lưu'),
                onPressed: _saveUserData,
              )
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Sửa'),
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
              ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CupertinoTextField(
              controller: _usernameController,
              placeholder: 'Tên người dùng',
              decoration: _isEditing ? null : const BoxDecoration(border: Border()), //Ẩn/hiện border
              padding: const EdgeInsets.all(12),
              readOnly: !_isEditing, //Chỉ đọc khi không chỉnh sửa
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              controller: _emailController,
              placeholder: 'Email',
              decoration: _isEditing ? null : const BoxDecoration(border: Border()),  //Ẩn/hiện border
              padding: const EdgeInsets.all(12),
              readOnly: !_isEditing,  //Chỉ đọc khi không chỉnh sửa
              keyboardType: TextInputType.emailAddress,
            ),
            // Các trường thông tin khác (nếu cần)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

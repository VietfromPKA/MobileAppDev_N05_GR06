import 'package:flutter/cupertino.dart';
import 'package:quan_ly_chi_tieu/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true; // Password visibility

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Đăng ký'),
        backgroundColor: CupertinoColors.systemGrey6,
        border: const Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.systemGrey)),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  CupertinoTextFormFieldRow(
                    controller: _emailController,
                    placeholder: 'Email',
                    prefix: const Icon(CupertinoIcons.mail),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
                        return 'Vui lòng nhập một địa chỉ email hợp lệ.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: _usernameController,
                    placeholder: 'Username',
                    prefix: const Icon(CupertinoIcons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField( // Changed from CupertinoTextFormFieldRow
                    controller: _passwordController,
                    placeholder: 'Mật khẩu',
                    prefix: const Padding( // Added padding
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(CupertinoIcons.lock),
                    ),
                    obscureText: _obscureText,
                    suffix: Padding( //Added padding
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoButton( // Suffix for show/hide
                        padding: EdgeInsets.zero,
                        child: Icon(
                          _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                          color: CupertinoColors.systemGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration( // Added decoration
                      border: Border.all(
                        color: CupertinoColors.systemGrey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isLoading)
                    const CupertinoActivityIndicator()
                  else
                    CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await AuthService().register(
                              _emailController.text,
                              _passwordController.text,
                              _usernameController.text,
                            );
                            // Show success dialog
                            _showSuccessDialog(context);
                          } catch (e) {
                            _showErrorDialog(context, e.toString());
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Thành công'),
          content: const Text('Đăng ký thành công!'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                Navigator.of(context).pop(); // Go back to the previous screen (login)
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text('Đăng ký không thành công: $errorMessage'),
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
}

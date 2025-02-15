import 'package:flutter/cupertino.dart';
import 'package:quan_ly_chi_tieu/screens/authentication/register_screen.dart';
import 'package:quan_ly_chi_tieu/screens/authentication/forgot_password_screen.dart';
import 'package:quan_ly_chi_tieu/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true; // Keep track of password visibility

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Đăng nhập'),
        backgroundColor: CupertinoColors.systemGrey6,  // Light background
        border: const Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.systemGrey)),
      ),
      child: SafeArea( // Add SafeArea
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Đăng nhập',
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
                  CupertinoTextField( // Changed from CupertinoTextFormFieldRow
                    controller: _passwordController,
                    placeholder: 'Mật khẩu',
                    prefix: const Padding(  // Added Padding
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(CupertinoIcons.lock),
                    ),
                    obscureText: _obscureText, // Use the obscureText variable
                    suffix: Padding(    // Added padding
                                          padding: const EdgeInsets.all(8.0),
                                          child: CupertinoButton(     // Suffix for show/hide
                        padding: EdgeInsets.zero,

                        child: Icon(_obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: CupertinoColors.systemGrey,),
                        onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },

                        ),
                                        ),
                    decoration: BoxDecoration(       // Added Decoration
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
                        //Dummy data to bypass login
                        //   await AuthService().login(_emailController.text, _passwordController.text, context);
                          Navigator.pushReplacement(
                              context, CupertinoPageRoute(builder: (context) => const HomeScreen()));
                        } catch (e) {
                          _showErrorDialog(context, e.toString());  // Show error dialog
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                    CupertinoButton( // Changed to CupertinoButton
                        child: const Text('Quên mật khẩu?', style: TextStyle(color: CupertinoColors.systemBlue),), // Style the text
                        onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => const ForgotPasswordScreen()));
                        },
                    ),
                  CupertinoButton( // Changed to CupertinoButton

                    child: const Text('Đăng ký tài khoản mới', style: TextStyle(color: CupertinoColors.systemBlue),),  //Style the text
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const RegisterScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


     void _showErrorDialog(BuildContext context, String errorMessage) { // Added error dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text('Đăng nhập không thành công: $errorMessage'),
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
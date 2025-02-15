import 'package:flutter/cupertino.dart';
import 'package:quan_ly_chi_tieu/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Quên mật khẩu'),
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
                    'Quên mật khẩu',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  CupertinoTextFormFieldRow(  // Use CupertinoTextFormFieldRow
                    controller: _emailController,
                    placeholder: 'Email', // Placeholder instead of labelText
                    prefix: const Icon(CupertinoIcons.mail), // Cupertino icon
                    keyboardType: TextInputType.emailAddress, // Specify keyboard type
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      // Add email validation (optional, but recommended)
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
                          return 'Vui lòng nhập một địa chỉ email hợp lệ.';
                        }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CupertinoActivityIndicator() // Cupertino Activity Indicator
                      : CupertinoButton.filled(  // Use CupertinoButton.filled
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // Optional padding, adjust as needed
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await AuthService().forgotPassword(_emailController.text);
                                // Use CupertinoAlertDialog for success message
                                _showSuccessDialog(context);

                              } catch (e) {
                                // Use CupertinoAlertDialog for error message
                                _showErrorDialog(context, e.toString());
                              } finally {
                                   setState(() {
                                      _isLoading = false;
                                    });
                              }
                            }
                          },
                          child: const Text(
                            'Gửi yêu cầu',
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
          content: const Text('Vui lòng kiểm tra email của bạn để được hướng dẫn đặt lại mật khẩu.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();  // Dismiss the dialog
                Navigator.of(context).pop();  // Go back to the previous screen
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
          content: Text('Không thể gửi email đặt lại: $errorMessage'),
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
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/services/auth_service.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = Provider.of<ExpenseProvider>(context).email;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cài đặt'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.mail_solid, color: CupertinoColors.activeBlue),
                    title: Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(email ?? '', style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () async {
                try {
                  await AuthService().logout();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  _showErrorDialog(context, e.toString());
                }
              },
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.square_arrow_right, color: CupertinoColors.white),
                  SizedBox(width: 5),
                  Text('Đăng xuất', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text('Đăng xuất không thành công: $errorMessage'),
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

class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;

  const CupertinoListTile({required this.leading, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                SizedBox(height: 5),
                subtitle,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

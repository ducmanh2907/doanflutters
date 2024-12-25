import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = usernameController.text;
    String password = passwordController.text;
    String fullname = fullnameController.text;

    // Kiểm tra trùng username
    if (prefs.getString('username') == username) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username đã tồn tại')));
    } else {
      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setString('fullname', fullname);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng ký thành công')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: fullnameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}

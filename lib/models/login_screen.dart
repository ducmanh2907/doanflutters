import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/DatabaseHelper.dart';
import 'MotoListScreen.dart'; // Trang Danh Sách Mô Tô

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    final dbHelper = DatabaseHelper();
    final user = await dbHelper.getUserByEmailAndPassword(username, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập thành công')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MotoListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sai thông tin đăng nhập')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập')),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
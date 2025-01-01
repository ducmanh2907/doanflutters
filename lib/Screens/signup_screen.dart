import 'package:banxe/Screens/MotoListScreen.dart';
import 'package:banxe/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController(); // Thêm trường tên người dùng
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Đăng ký người dùng và lưu thông tin vào Firestore
  Future<void> _signUp() async {
    try {
      // Tạo người dùng mới
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Lưu thông tin người dùng vào Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'createdAt': Timestamp.now(),
      });

      // Chuyển sang màn hình chính sau khi đăng ký thành công
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MotoListScreen()),  // Chuyển đến màn hình danh sách mô tô
      );
    } on FirebaseAuthException catch (e) {
      // Hiển thị thông báo lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Trường tên người dùng
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            // Nút "Login" để điều hướng đến màn hình đăng nhập
            TextButton(
              onPressed: () {
                // Điều hướng đến màn hình đăng nhập
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),  // Chuyển đến màn hình đăng nhập
                );
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

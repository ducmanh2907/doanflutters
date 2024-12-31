import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  // Khởi tạo Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String fullname = fullnameController.text.trim();

    if (username.isEmpty || password.isEmpty || fullname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin.')),
      );
      return;
    }

    try {
      // Đăng ký người dùng mới
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Sau khi đăng ký thành công, bạn có thể lưu thông tin khác như tên đầy đủ vào Firestore (nếu muốn)
      // Lưu tên đầy đủ vào Firestore hoặc Realtime Database (nếu cần)
      // Firestore.instance.collection('users').doc(userCredential.user?.uid).set({
      //   'fullname': fullname,
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thành công')),
      );
      // Chuyển đến HomeScreen sau khi đăng ký thành công
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Xử lý lỗi khi đăng ký
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thất bại: ${e.message}')),
      );
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
              decoration: InputDecoration(labelText: 'Email (Username)'),
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

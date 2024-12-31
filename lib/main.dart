import 'package:banxe/Screens/home_screen.dart';
import 'package:banxe/models/MotoListScreen.dart';
import 'package:banxe/models/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Services/firebase_options.dart'; // Đảm bảo đúng đường dẫn tới file firebase_options.dart

void main() async {
  // Đảm bảo Flutter framework được khởi tạo trước khi chạy Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase với cấu hình từ firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Khởi tạo Firebase bằng cấu hình này
  );

  // Chạy ứng dụng
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MotoListScreen(), // Màn hình chính của ứng dụng
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/sign_up_screen.dart';
import '../Screens/home_screen.dart'; // Đảm bảo bạn đã tạo màn hình HomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => sign_up_screen(),
        '/home': (context) => home_screen(), // Màn hình chính sau khi đăng nhập
      },
    );
  }

  home_screen() {}

  sign_up_screen() {}
}

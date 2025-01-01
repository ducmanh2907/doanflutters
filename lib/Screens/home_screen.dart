import 'package:banxe/Screens/MotoListScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup_screen.dart';
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
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => MotoListScreen(), // Màn hình chính sau khi đăng nhập
      },
    );
  }
}


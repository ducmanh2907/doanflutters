import 'package:banxe/Screens/MotoListScreen.dart';
import 'package:banxe/Screens/login_screen.dart';
import 'package:banxe/Screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core_web/firebase_core_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cung cấp FirebaseOptions cho web
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBOrM6TqoxD8PNWb8NFH7Fa-Sn_jIXnPCY",
        authDomain: "doanflutter-49238.firebaseapp.com",
        databaseURL: "https://doanflutter-49238-default-rtdb.firebaseio.com",
        projectId: "doanflutter-49238",
        storageBucket: "doanflutter-49238.firebasestorage.app",
        messagingSenderId: "1058935328786",
        appId: "1:1058935328786:web:9de30c14c516b5d85f08cb",
        measurementId: "G-L7NS025W97"
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Màn hình đầu tiên là màn hình đăng nhập
      routes: {
        '/login': (context) => SignUpScreen(),
        '/signup': (context) => SignInScreen(),
        '/home': (context) => MotoListScreen(),
      },
    );
  }
}
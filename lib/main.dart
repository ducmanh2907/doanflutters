import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/DatabaseHelper.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Đăng nhập và Đăng ký',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Chiếm toàn bộ chiều ngang
        height: double.infinity, // Chiếm toàn bộ chiều dọc
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://mcdn.coolmate.me/image/May2022/xe-do-1-3-1.jpg',
            ),
            fit: BoxFit.fill, // Ép ảnh lấp đầy
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(), // Đẩy nội dung phía dưới lên
            Text(
              'Welcome Moto Joyal',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 2), // Viền trắng
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Chữ màu trắng
                ),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 2), // Viền trắng
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                'Đăng ký',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Chữ màu trắng
                ),
              ),
            ),
            Spacer(), // Đẩy nội dung phía trên xuống
          ],
        ),
      ),
    );
  }
}
class MotoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Danh sách mô tô giả lập
    final List<Map<String, dynamic>> motoList = [
      {
        'name': 'Moto Yamaha R15',
        'price': 3500,
        'imageUrl': 'https://example.com/yamaha_r15.jpg',
      },
      {
        'name': 'Moto Kawasaki Ninja',
        'price': 5500,
        'imageUrl': 'https://example.com/kawasaki_ninja.jpg',
      },
      {
        'name': 'Moto Ducati Panigale',
        'price': 10000,
        'imageUrl': 'https://example.com/ducati_panigale.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách mô tô'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: ListView.builder(
        itemCount: motoList.length,
        itemBuilder: (context, index) {
          final moto = motoList[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                moto['imageUrl'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(moto['name']),
              subtitle: Text('Giá: \$${moto['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${moto['name']} đã được thêm vào giỏ hàng!')),
                  );
                },
                child: Text('Mua'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    if (usersJson != null) {
      List<dynamic> users = List<dynamic>.from(json.decode(usersJson));
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      final user = users.firstWhere(
            (user) => user['username'] == username && user['password'] == password,
        orElse: () => null,
      );
      if (user != null) {
        prefs.setString('current_user', json.encode(user));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotoListScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sai thông tin đăng nhập")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Không tìm thấy người dùng")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => login(context), child: Text("Đăng nhập")),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String email = emailController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin.')),
      );
      return;
    }

    // Get the existing users and check if the username already exists
    String? usersJson = prefs.getString('users');
    List<dynamic> users = usersJson != null ? List<dynamic>.from(json.decode(usersJson)) : [];

    if (users.any((user) => user['username'] == username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username đã tồn tại')),
      );
      return;
    }

    // Add the new user to the list
    users.add({
      'username': username,
      'password': password,
      'email': email, // Storing email instead of fullname
    });

    prefs.setString('users', json.encode(users));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng ký thành công')),
    );
    Navigator.pop(context); // Close the sign-up screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')), // Changed label to Email
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: const Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      NotesScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Màn hình chính")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Notes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Danh sách ghi chú"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Thông tin cá nhân"));
  }
}
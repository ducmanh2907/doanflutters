import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Giả sử bạn đã lưu giỏ hàng vào SharedPreferences hoặc Database
    final List<Map<String, dynamic>> cartItems = [
      {'name': 'Moto Yamaha R15', 'price': 3500, 'quantity': 1},
      {'name': 'Moto Kawasaki Ninja', 'price': 5500, 'quantity': 2},
    ];

    double totalPrice = cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Giá: \$${item['price']} x ${item['quantity']}'),
                  trailing: Text('Tổng: \$${item['price'] * item['quantity']}'),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tổng giá trị: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
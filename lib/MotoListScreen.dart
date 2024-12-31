import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MotoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

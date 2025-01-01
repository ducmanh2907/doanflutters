import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MotoListScreen extends StatelessWidget {
  const MotoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moto List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Motos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No motos found.'));
          }

          final motoDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: motoDocs.length,
            itemBuilder: (context, index) {
              final moto = motoDocs[index];
              final name = moto['name'] ?? 'Unknown Moto';
              final price = moto['price'] ?? 'N/A';
              final imageUrl = moto['imageUrl'] ?? 'https://via.placeholder.com/150'; // Thêm ảnh nếu có

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hiển thị ảnh mô tô
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 10),

                      // Hiển thị tên mô tô và giá
                      Text(
                        name,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('Price: \$${price}', style: TextStyle(fontSize: 18, color: Colors.green)),
                      SizedBox(height: 10),

                      // Các nút Mua và Đặt hàng
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showConfirmationDialog(context, 'Buy', name);
                            },
                            child: Text('Buy'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Màu nút Mua
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showConfirmationDialog(context, 'Order', name);
                            },
                            child: Text('Order'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Màu nút Đặt hàng
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Hàm hiển thị popup xác nhận hành động
  void _showConfirmationDialog(BuildContext context, String action, String motoName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action Confirmation'),
          content: Text('Are you sure you want to $action $motoName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You have successfully $action the $motoName!')),
                );
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

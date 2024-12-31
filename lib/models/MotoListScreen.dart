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
      {
        'name': 'Moto Honda CBR500R',
        'price': 7000,
        'imageUrl': 'https://example.com/honda_cbr500r.jpg',
      },
      {
        'name': 'Moto Suzuki Hayabusa',
        'price': 15000,
        'imageUrl': 'https://example.com/suzuki_hayabusa.jpg',
      },
      {
        'name': 'Moto BMW S1000RR',
        'price': 20000,
        'imageUrl': 'https://example.com/bmw_s1000rr.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách mô tô'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Giỏ hàng đang được cập nhật!')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm mô tô...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: motoList.length,
                itemBuilder: (context, index) {
                  final moto = motoList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            moto['imageUrl'],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moto['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${moto['price']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${moto['name']} đã được thêm vào giỏ hàng!')),
                              );
                            },
                            child: Text('Mua ngay'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

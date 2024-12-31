// lib/models/cart_item.dart

class CartItem {
  final String id;
  final String motoId;
  final String name;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.motoId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  // Chuyển CartItem thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'motoId': motoId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  // Tạo CartItem từ Map (lấy từ SQLite)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'].toString(),
      motoId: map['motoId'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
    );
  }

  // Tính tổng giá trị sản phẩm trong giỏ
  double get totalPrice => quantity * price;
}

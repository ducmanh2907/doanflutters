// lib/models/cart.dart

import 'CartItem.dart';
 // Lớp CartItem bạn đã tạo
import 'moto.dart';  // Lớp Moto bạn đã tạo

class Cart {
  final List<CartItem> items = [];  // Danh sách các mục trong giỏ hàng

  // Thêm sản phẩm vào giỏ hàng
  void addProduct(Moto moto) {
    // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
    final existingItem = items.firstWhere(
          (item) => item.motoId == moto.id,
      orElse: () => CartItem(
        id: DateTime.now().toString(),  // Tạo ID duy nhất cho mục mới
        motoId: moto.id,
        name: moto.name,
        quantity: 0,
        price: moto.price,
      ),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;  // Tăng số lượng nếu sản phẩm đã có
    } else {
      items.add(CartItem(
        id: DateTime.now().toString(),
        motoId: moto.id,
        name: moto.name,
        quantity: 1,
        price: moto.price,
      ));  // Thêm sản phẩm mới vào giỏ hàng
    }
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeProduct(Moto moto) {
    items.removeWhere((item) => item.motoId == moto.id);
  }

  // Giảm số lượng sản phẩm trong giỏ hàng
  void decreaseQuantity(Moto moto) {
    final existingItem = items.firstWhere(
          (item) => item.motoId == moto.id,
      orElse: () => CartItem(
        id: DateTime.now().toString(),
        motoId: moto.id,
        name: moto.name,
        quantity: 0,
        price: moto.price,
      ),
    );

    if (existingItem.quantity > 1) {
      existingItem.quantity--;  // Giảm số lượng
    } else {
      removeProduct(moto);  // Xóa nếu số lượng là 1
    }
  }

  // Tổng số lượng sản phẩm trong giỏ hàng
  int get totalItems {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  // Tổng giá trị giỏ hàng
  double get totalPrice {
    return items.fold(0, (total, item) => total + item.quantity * item.price);
  }

  // Xóa toàn bộ giỏ hàng
  void clearCart() {
    items.clear();
  }

  // Phương thức lấy tất cả sản phẩm trong giỏ
  List<CartItem> getAllItems() {
    return items;
  }
}

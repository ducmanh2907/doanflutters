class Menu {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool isAvailable;

  // Constructor
  Menu({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isAvailable,
  });

  // Phương thức chuyển đối tượng Menu thành Map để dễ dàng gửi qua API hoặc lưu vào database
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'isAvailable': isAvailable,
  };

  // Phương thức khôi phục đối tượng Menu từ Map (thường dùng để giải mã dữ liệu từ API)
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      isAvailable: json['isAvailable'],
    );
  }
}

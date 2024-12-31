// lib/models/moto.dart
class Moto {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;
  final int stock;

  Moto({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
  });
}
// lib/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      name: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }
}
// lib/model/user.dart

class User {
  int? id; // id là optional vì có thể chưa được gán khi tạo mới
  String username;
  String email;
  String phoneNumber;
  String address;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  // Chuyển User thành Map để lưu vào cơ sở dữ liệu
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // Tạo User từ Map lấy ra từ cơ sở dữ liệu
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }
}

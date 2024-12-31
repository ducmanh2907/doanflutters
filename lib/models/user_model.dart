class UserModel {
  String id;
  String name;
  int age;

  UserModel({required this.id, required this.name, required this.age});

  // Tạo đối tượng UserModel từ Map<String, dynamic>
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '', // Lấy giá trị 'id' từ Map
      name: data['name'] ?? '', // Lấy giá trị 'name' từ Map
      age: data['age'] ?? 0, // Lấy giá trị 'age' từ Map
    );
  }

  // Chuyển UserModel thành Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
